//
// Bitmovin Player iOS SDK
// Copyright (C) 2017, Bitmovin GmbH, All Rights Reserved
//
// This source code and its use and distribution, is subject to the terms
// and conditions of the applicable license agreement.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@class BMPOfflineConfig;
@class BMPThumbnailTrack;
@protocol BMPOfflineDownloadsHandlerListener;
@protocol BMPAssetDownloadTask;

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(_OfflineDownloadsHandler)
@protocol _BMPOfflineDownloadsHandler <NSObject>
- (void)setCompletionHandler:(void (^)(void))backgroundCompletionHandler forSessionIdentifier:(NSString *)identifier;
- (void)setRestoringTasksCompletionHandler:(void (^)(void))completionHandler;
- (void)restoreBackgroundSessions;
- (nullable id<BMPAssetDownloadTask>)assetDownloadTaskWithURLAsset:(AVURLAsset *)URLAsset
                                                        identifier:(NSString *)identifier
                                                        assetTitle:(NSString *)title
                                                  assetArtworkData:(nullable NSData *)artworkData
                                                   mediaSelections:(NSArray<AVMediaSelection *> *)mediaSelections
                                                           options:(nullable NSDictionary<NSString *, id> *)options;
- (void)addListener:(id<BMPOfflineDownloadsHandlerListener>)listener;
- (void)removeListener:(id<BMPOfflineDownloadsHandlerListener>)listener;
- (nullable id<BMPAssetDownloadTask>)activeTaskForIdentifier:(NSString *)identifier;
- (nullable NSString *)fetchAndRemoveRelativeContentPathForIdentifier:(NSString *)identifier;
- (void)setRestrictMediaDownloadsToWiFi:(BOOL)restrictMediaDownloadsToWiFi;
@end

NS_ASSUME_NONNULL_END
