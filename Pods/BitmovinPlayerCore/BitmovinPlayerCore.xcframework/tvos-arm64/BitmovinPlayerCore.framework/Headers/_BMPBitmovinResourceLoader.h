//
// Bitmovin Player iOS SDK
// Copyright (C) 2020, Bitmovin GmbH, All Rights Reserved
//
// This source code and its use and distribution, is subject to the terms
// and conditions of the applicable license agreement.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <BitmovinPlayerCore/_BMPBitmovinResourceLoaderDelegate.h>

@protocol _BMPPlaylistUrlTracker;
@protocol _BMPObjCLoggerService;
@class BMPSourceConfig;
@class BMPNetworkConfig;
@class BMPContentDecryptionKeyLoader;
@class BMPPlaylistLoader;

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(_BitmovinResourceLoader)
@interface _BMPBitmovinResourceLoader : NSObject <AVAssetResourceLoaderDelegate>
@property (nonatomic, weak) id<_BMPBitmovinResourceLoaderDelegate> delegate;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)initWithSourceConfig:(BMPSourceConfig *)sourceConfig
                       networkConfig:(BMPNetworkConfig *)networkConfig
                       loggerService:(id<_BMPObjCLoggerService>)loggerService;
- (instancetype)initWithSourceConfig:(BMPSourceConfig *)sourceConfig
                       networkConfig:(BMPNetworkConfig *)networkConfig
                      playlistLoader:(BMPPlaylistLoader *)playlistLoader
                           keyLoader:(BMPContentDecryptionKeyLoader *)keyLoader
                  playlistUrlTracker:(id<_BMPPlaylistUrlTracker>)playlistUrlTracker
                       loggerService:(id<_BMPObjCLoggerService>)loggerService NS_DESIGNATED_INITIALIZER;
@end

NS_ASSUME_NONNULL_END
