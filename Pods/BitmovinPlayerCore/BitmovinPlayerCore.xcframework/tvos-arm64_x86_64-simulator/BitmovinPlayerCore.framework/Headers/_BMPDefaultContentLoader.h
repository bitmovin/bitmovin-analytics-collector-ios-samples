//
// Bitmovin Player iOS SDK
// Copyright (C) 2018, Bitmovin GmbH, All Rights Reserved
//
// This source code and its use and distribution, is subject to the terms
// and conditions of the applicable license agreement.
//

#import <Foundation/Foundation.h>
#import <BitmovinPlayerCore/BMPHttpRequestTypes.h>
#import <BitmovinPlayerCore/_BMPContentLoader.h>
@protocol _BMPObjCLoggerService;

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(_DefaultContentLoader)
@interface _BMPDefaultContentLoader : NSObject<_BMPContentLoader>
@property (weak, nonatomic, nullable) id<_BMPContentLoaderDelegate> delegate;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)initWithRequestType:(BMPHttpRequestType)requestType
                      loggerService:(id<_BMPObjCLoggerService>)loggerService NS_DESIGNATED_INITIALIZER;
@end

NS_ASSUME_NONNULL_END
