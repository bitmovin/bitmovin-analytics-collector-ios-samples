//
// Bitmovin Player iOS SDK
// Copyright (C) 2020, Bitmovin GmbH, All Rights Reserved
//
// This source code and its use and distribution, is subject to the terms
// and conditions of the applicable license agreement.
//

#import <Foundation/Foundation.h>

@class BMPSourceConfig;
@protocol BMPOfflineClearKeyHandlerListener;

NS_ASSUME_NONNULL_BEGIN

/**
 Handles downloading and persisting of decryption keys for ClearKey protected content.
 */
NS_SWIFT_NAME(_OfflineClearKeyHandler)
@protocol _BMPOfflineClearKeyHandler <NSObject>
- (void)addListener:(id<BMPOfflineClearKeyHandlerListener>)listener;
- (void)removeListener:(id<BMPOfflineClearKeyHandlerListener>)listener;
- (void)setCompletionHandler:(void (^)(void))backgroundCompletionHandler forSessionIdentifier:(NSString *)identifier;
- (void)restoreBackgroundSession;
- (void)replaceKeyUrlsWithDataUrisForSourceIdentifier:(NSString *)identifier
                                          withBaseUrl:(NSURL *)baseUrl
                                    atContentLocation:(NSURL *)contentLocation NS_SWIFT_NAME(replaceKeyUrlsWithDataUris(for:withBaseUrl:atContentLocation:));
- (BOOL)hasPendingTasksForSourceIdentifier:(NSString *)identifier NS_SWIFT_NAME(hasPendingTasks(for:));
@end

NS_ASSUME_NONNULL_END
