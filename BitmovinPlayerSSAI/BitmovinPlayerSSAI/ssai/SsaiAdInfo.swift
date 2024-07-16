import CoreCollector
import Foundation

class SsaiAdInfo: NSObject {
    init(
        adMetadata: SsaiAdMetadata,
        adBreakMetadata: SsaiAdBreakMetadata,
        scheduledAt: Int,
        durationSeconds: Int,
        isLastInAdBreak: Bool
    ) {
        self.adMetadata = adMetadata
        self.adBreakMetadata = adBreakMetadata
        self.scheduledAt = scheduledAt
        self.durationSeconds = durationSeconds
        self.isLastInAdBreak = isLastInAdBreak
    }
    
    let adMetadata: SsaiAdMetadata
    let adBreakMetadata: SsaiAdBreakMetadata
    let scheduledAt: Int
    let durationSeconds: Int
    let isLastInAdBreak: Bool
}
