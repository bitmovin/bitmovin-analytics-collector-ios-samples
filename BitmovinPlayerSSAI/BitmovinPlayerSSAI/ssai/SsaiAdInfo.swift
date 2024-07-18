import CoreCollector
import Foundation

class SsaiAdInfo: NSObject {
    init(
        adMetadata: SsaiAdMetadata,
        adBreakMetadata: SsaiAdBreakMetadata,
        scheduledAtSeconds: Int,
        durationSeconds: Int,
        isLastInAdBreak: Bool
    ) {
        self.adMetadata = adMetadata
        self.adBreakMetadata = adBreakMetadata
        self.scheduledAtSeconds = scheduledAtSeconds
        self.durationSeconds = durationSeconds
        self.isLastInAdBreak = isLastInAdBreak
    }
    
    let adMetadata: SsaiAdMetadata
    let adBreakMetadata: SsaiAdBreakMetadata
    let scheduledAtSeconds: Int
    let durationSeconds: Int
    let isLastInAdBreak: Bool
}
