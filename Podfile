platform :ios, '15.0'
use_frameworks!

source 'https://github.com/CocoaPods/Specs.git'
# source 'https://github.com/bitmovin/cocoapod-specs.git'

workspace 'BitmoviniOSCollectorSamples'


def analytics_collector_version = '3.24.0-a.5'

target 'AVFoundationPlayerBasicSetup' do
  project 'AVFoundationPlayerBasicSetup/AVFoundationPlayerBasicSetup.xcodeproj'
  pod 'BitmovinAnalyticsCollector/Core', analytics_collector_version
  pod 'BitmovinAnalyticsCollector/AVPlayer', analytics_collector_version
end

target 'BitmovinPlayerPlaylist' do
  project 'BitmovinPlayerPlaylist/BitmovinPlayerPlaylist.xcodeproj'
  pod 'BitmovinPlayer', '3.99.0'
  pod 'BitmovinAnalyticsCollector/Core', analytics_collector_version
  pod 'BitmovinAnalyticsCollector/BitmovinPlayer', analytics_collector_version
end

target 'THEOplayerBasicSetup' do
  project 'THEOplayerBasicSetup/THEOplayerBasicSetup.xcodeproj'
  pod 'THEOplayerSDK-core', '11.0.0'
  pod 'BitmovinAnalyticsCollector/Core', analytics_collector_version
  pod 'BitmovinAnalyticsCollector/THEOplayer', analytics_collector_version
end

target 'THEOplayerAds' do
  project 'THEOplayerAds/THEOplayerAds.xcodeproj'
  pod 'GoogleAds-IMA-iOS-SDK', '3.24.0'
end
