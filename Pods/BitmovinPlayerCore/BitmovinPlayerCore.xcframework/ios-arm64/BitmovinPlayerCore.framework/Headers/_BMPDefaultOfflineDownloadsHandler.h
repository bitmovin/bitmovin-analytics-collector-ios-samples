//
// Bitmovin Player iOS SDK
// Copyright (C) 2017, Bitmovin GmbH, All Rights Reserved
//
// This source code and its use and distribution, is subject to the terms
// and conditions of the applicable license agreement.
//

#import <Foundation/Foundation.h>

@protocol _BMPObjCLoggerService;
@class BMPOfflineConfig;
@protocol _BMPOfflineDownloadsHandler;

#if TARGET_OS_IOS && !TARGET_OS_SIMULATOR
NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(_DefaultOfflineDownloadsHandler)
@interface _BMPDefaultOfflineDownloadsHandler : NSObject <_BMPOfflineDownloadsHandler>
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)initWithOfflineConfig:(BMPOfflineConfig *)offlineConfig
                        loggerService:(id<_BMPObjCLoggerService>)loggerService NS_DESIGNATED_INITIALIZER;
@end

NS_ASSUME_NONNULL_END
#endif
