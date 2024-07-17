import BitmovinCollector
import BitmovinPlayer
import CoreCollector

class BitmovinPlayerSsaiAdScheduler: NSObject {

    static let beforeAdTimeSpan = 200

    private let player: Player
    private let collector: PlayerAnalyticsApi
    private var adsScheduled: [SsaiAdInfo] = []
    private var activeAd: SsaiAdInfo?
    private var nextAd: SsaiAdInfo?

    init(player: any Player, collector: any PlayerAnalyticsApi) {
        self.player = player
        self.collector = collector
    }

    /// Schedules the ads.
    /// Listens to the player events to know when ads should be tracked
    func scheduleAds(ads: [SsaiAdInfo]) {
        player.add(listener: self)
        self.adsScheduled = []
        self.adsScheduled.append(contentsOf: ads)
        self.adsScheduled.sort { ad1, ad2 in
            return ad1.scheduledAt < ad2.scheduledAt
        }

        // here we assume the player starts the stream at position 0
        nextAd = getNextAd(currentTime: 0)
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

    
    /// Stop the tracking of the current active ad
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
        guard let currentTime = event.currentTime.milliseconds else {
            return
        }
        if let ad = activeAd, ad.isLastInAdBreak == true {
            checkForAdStop(ad: ad, currentTime: currentTime)
        }
        checkForAdStart(currentTime: currentTime)

        if adsScheduled.isEmpty {
            print("no ads scheduled: detaching scheduler")
            self.detach()
        }
    }

    /// Checks if there is an ad scheduled for which tracking should be started
    /// It will start ad tracking 200 milliseconds prior to the ads start
    private func checkForAdStart(currentTime: Int) {
        // only continue here if there is a next ad
        guard let nextAd else {
            return
        }

        // we want to start tracking a few milliseconds prior to the actual ad start
        // to catch potential error during the transition
        let timeUntilAd = (nextAd.scheduledAt * 1000) - currentTime
        print("time until ad start: \(timeUntilAd)")
        if timeUntilAd < BitmovinPlayerSsaiAdScheduler.beforeAdTimeSpan {
            print("ad start at: \(currentTime)")
            self.startTrackingAd(ad: nextAd)
            self.nextAd = getNextAd(currentTime: currentTime)
        }
    }

    /// Checks if the ad is about to stop
    /// It will stop ad tracking 200 milliseconds prior to the end of the ad
    private func checkForAdStop(ad: SsaiAdInfo, currentTime: Int) {
        let stopAt = ad.scheduledAt + ad.durationSeconds
        let timeUntilAd = (stopAt * 1000) - currentTime
        print("time until ad stop: \(timeUntilAd)")
        if timeUntilAd < BitmovinPlayerSsaiAdScheduler.beforeAdTimeSpan {
            print("ad stop at: \(currentTime)")
            self.stopTrackingAd()
            self.nextAd = getNextAd(currentTime: currentTime)
        }
    }


    /// Returns the next scheduled ad relative to currentTime
    private func getNextAd(currentTime: Int) -> SsaiAdInfo? {
        let potentialNext = self.adsScheduled.first { ad in
            ad.scheduledAt * 1000 >= currentTime && ad != activeAd
        }

        return potentialNext
    }
}
