//
// Bitmovin Player iOS SDK
// Copyright (C) 2020, Bitmovin GmbH, All Rights Reserved
//
// This source code and its use and distribution, is subject to the terms
// and conditions of the applicable license agreement.
//

#import <Foundation/Foundation.h>

@protocol _BMPOfflineClearKeyHandler;
@protocol _BMPObjCLoggerService;

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(_DefaultOfflineClearKeyHandler)
@interface _BMPDefaultOfflineClearKeyHandler : NSObject <_BMPOfflineClearKeyHandler>
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)initWithLoggerService:(id<_BMPObjCLoggerService>)loggerService;
- (instancetype)initWithDownloadSession:(NSURLSession *)downloadSession
                          loggerService:(id<_BMPObjCLoggerService>)loggerService NS_DESIGNATED_INITIALIZER;
@end

NS_ASSUME_NONNULL_END
