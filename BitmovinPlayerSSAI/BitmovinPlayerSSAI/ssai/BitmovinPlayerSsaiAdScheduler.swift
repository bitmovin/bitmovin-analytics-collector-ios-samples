import BitmovinCollector
import BitmovinPlayer
import CoreCollector

class BitmovinPlayerSsaiAdScheduler: NSObject {

    /// To accurately track potential errors during the stream-to-ad and ad-to-stream transitions, ad tracking should start shortly before the ad begins and stop shortly after the ad ends. 
    /// This approach ensures that error data is connected to the relevant ad data, preventing any loss of correlation between errors and ads.
    static let adTrackingWindowMs = 200

    private let player: Player
    private let collector: PlayerAnalyticsApi
    private var adsScheduled: [SsaiAdInfo] = []
    private var activeAd: SsaiAdInfo?
    private var nextAd: SsaiAdInfo?

    init(player: any Player, collector: any PlayerAnalyticsApi) {
        self.player = player
        self.collector = collector
    }

    /// Sorts and schedules the ads.
    /// Adds listener for player events (e.g onTimeChanged) to know when ads should be tracked
    func scheduleAds(ads: [SsaiAdInfo]) {
        player.add(listener: self)
        self.adsScheduled = []
        self.adsScheduled.append(contentsOf: ads)
        self.adsScheduled.sort { ad1, ad2 in
            return ad1.scheduledAtSeconds < ad2.scheduledAtSeconds
        }

        // here we assume the player starts the stream at position 0
        nextAd = getNextAd(currentTimeMs: 0)
    }


    /// Stop the scheduling of ads
    func detach() {
        player.remove(listener: self)
        collector.ssai.adBreakEnd()
        activeAd = nil
    }


    /// Start to track the given ad by passing it to the analytics collector api
    /// Automatically detects when an adbreak starts
    func startTrackingAd(ad: SsaiAdInfo) {
        if activeAd == nil {
            collector.ssai.adBreakStart(adBreakMetadata: ad.adBreakMetadata)
        }
        if let activeAd {
            // remove current active ad from the scheduled ads as it is finished
            self.removeFromScheduleAds(ad: activeAd)
        }
        activeAd = ad
        collector.ssai.adStart(adMetadata: ad.adMetadata)
    }

    
    /// Stop the tracking of the current active ad and closes the adBreak
    func stopTrackingAd() {
        collector.ssai.adBreakEnd()

        if let activeAd {
            // remove current active ad from the scheduled ads as it is finished
            self.removeFromScheduleAds(ad: activeAd)
        }
        activeAd = nil
    }

    private func removeFromScheduleAds(ad: SsaiAdInfo) {
        // remove current active ad from the scheduled ads as it is finished
        if let activeAdIndex = adsScheduled.firstIndex(of: ad) {
            adsScheduled.remove(at: activeAdIndex)
        }
    }
}

extension BitmovinPlayerSsaiAdScheduler: PlayerListener {
    func onTimeChanged(_ event: TimeChangedEvent, player: any Player) {
        print("onTimeChangeEvent currentTime: \(event.currentTime)")
        guard let currentTimeMs = event.currentTime.milliseconds else {
            return
        }
        if let ad = activeAd, ad.isLastInAdBreak == true {
            checkForAdStop(ad: ad, currentTimeMs: currentTimeMs)
        }
        checkForAdStart(currentTimeMs: currentTimeMs)

        if adsScheduled.isEmpty {
            print("no ads scheduled: detaching scheduler")
            self.detach()
        }
    }

    /// Checks if there is an ad scheduled for which tracking should be started
    /// It will start ad tracking adTrackingWindowMs prior to the ads start
    private func checkForAdStart(currentTimeMs: Int) {
        // only continue here if there is a next ad
        guard let nextAd else {
            return
        }

        // we want to start tracking a few milliseconds prior to the actual ad start
        // to catch potential error during the transition
        let timeUntilAdMs = (nextAd.scheduledAtSeconds * 1000) - currentTimeMs
        print("time until ad start: \(timeUntilAdMs)")
        if timeUntilAdMs < BitmovinPlayerSsaiAdScheduler.adTrackingWindowMs {
            print("ad start at: \(currentTimeMs)")
            self.startTrackingAd(ad: nextAd)
            self.nextAd = getNextAd(currentTimeMs: currentTimeMs)
        }
    }

    /// Checks if the ad already stopped
    /// It will stop ad tracking adTrackingWindowMs after the end of the ad
    private func checkForAdStop(ad: SsaiAdInfo, currentTimeMs: Int) {
        let stopAtSeconds = ad.scheduledAtSeconds + ad.durationSeconds
        let timeAfterAdStop = currentTimeMs - (stopAtSeconds * 1000)
        print("time after ad stop: \(timeAfterAdStop)")
        if timeAfterAdStop > BitmovinPlayerSsaiAdScheduler.adTrackingWindowMs {
            print("ad stop at: \(currentTimeMs)")
            self.stopTrackingAd()
            self.nextAd = getNextAd(currentTimeMs: currentTimeMs)
        }
    }


    /// Returns the next scheduled ad relative to currentTime
    private func getNextAd(currentTimeMs: Int) -> SsaiAdInfo? {
        let potentialNext = self.adsScheduled.first { ad in
            ad.scheduledAtSeconds * 1000 >= currentTimeMs && ad != activeAd
        }

        return potentialNext
    }
}
