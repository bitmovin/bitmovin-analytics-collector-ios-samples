import CoreCollector

let preroll = SsaiAdBreakMetadata(adPosition: .preroll)
let midroll = SsaiAdBreakMetadata(adPosition: .midroll)

let staticAds = [
    SsaiAdInfo(
        adMetadata: SsaiAdMetadata(adId: "ad-1", adSystem: "static-ad-setup", customData: CustomData(customData1: "ad-1-customData")),
        adBreakMetadata: preroll,
        scheduledAtSeconds: 0,
        durationSeconds: 10,
        isLastInAdBreak: false
    ),
    SsaiAdInfo(
        adMetadata: SsaiAdMetadata(adId: "ad-2", adSystem: "static-ad-setup", customData: CustomData(customData1: "ad-2-customData")),
        adBreakMetadata: preroll,
        scheduledAtSeconds: 10,
        durationSeconds: 10,
        isLastInAdBreak: true
    ),
    SsaiAdInfo(
        adMetadata: SsaiAdMetadata(adId: "ad-3", adSystem: "static-ad-setup", customData: CustomData(customData1: "ad-3-customData")),
        adBreakMetadata: midroll,
        scheduledAtSeconds: 30,
        durationSeconds: 10,
        isLastInAdBreak: true
    )
]

class StaticSsaiInformationProvider: SsaiInformationProvider {
    let ads: [SsaiAdInfo]
    init(ads: [SsaiAdInfo]) {
        self.ads = ads
    }

    convenience init() {
        self.init(ads: staticAds)
    }

    func fetchAdInformation() -> [SsaiAdInfo] {
        return self.ads
    }
}

