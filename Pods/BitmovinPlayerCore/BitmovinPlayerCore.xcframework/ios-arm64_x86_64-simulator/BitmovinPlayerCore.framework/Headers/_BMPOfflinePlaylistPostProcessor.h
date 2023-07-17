//
// Bitmovin Player iOS SDK
// Copyright (C) 2020, Bitmovin GmbH, All Rights Reserved
//
// This source code and its use and distribution, is subject to the terms
// and conditions of the applicable license agreement.
//

#import <Foundation/Foundation.h>

@class BMPSourceConfig;
@protocol BMPOfflinePlaylistPostProcessorStep;

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(_OfflinePlaylistPostProcessor)
@protocol _BMPOfflinePlaylistPostProcessor<NSObject>
@property (nonatomic, readonly) BOOL isInProgress;
- (void)addStep:(id<BMPOfflinePlaylistPostProcessorStep>)step NS_SWIFT_NAME(add(step:));
- (BOOL)processForSourceConfig:(BMPSourceConfig *)sourceConfig atContentLocation:(NSURL *)contentLocation withError:(NSError **)error NS_SWIFT_NAME(process(sourceConfig:atContentLocation:));
- (void)resetSteps;
@end

NS_ASSUME_NONNULL_END
