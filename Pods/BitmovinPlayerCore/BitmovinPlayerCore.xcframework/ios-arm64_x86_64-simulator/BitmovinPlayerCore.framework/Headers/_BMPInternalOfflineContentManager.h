//
// Bitmovin Player iOS SDK
// Copyright (C) 2021, Bitmovin GmbH, All Rights Reserved
//
// This source code and its use and distribution, is subject to the terms
// and conditions of the applicable license agreement.
//

#import <Foundation/Foundation.h>
#import <BitmovinPlayerCore/BMPOfflineContentManager.h>

@class BMPOfflineTrackSelection;
@class BMPDownloadConfig;

NS_ASSUME_NONNULL_BEGIN

/**
 Adding additional internal functionality to the `OfflineContentManager` without exposing it
 */
NS_SWIFT_NAME(_InternalOfflineContentManager)
@protocol _BMPInternalOfflineContentManager <BMPOfflineContentManager>
@property (nonatomic, strong) BMPSourceConfig *sourceConfig;
@property (nonatomic) BOOL restrictMediaDownloadsToWiFi;
@property (nonatomic, readonly) double lastKnownProgress;

- (void)setCompletionHandler:(void (^)(void))backgroundCompletionHandler forSessionIdentifier:(NSString *)identifier;
- (void)downloadWithDownloadConfig:(BMPDownloadConfig *)downloadConfig tracks:(nullable BMPOfflineTrackSelection *)tracks;
@end

NS_ASSUME_NONNULL_END
