platform :ios, '14.0'
use_frameworks!

source 'https://cdn.cocoapods.org'
source 'https://github.com/bitmovin/cocoapod-specs.git'

workspace 'BitmoviniOSCollectorSamples'


def analytics_collector
  pod 'BitmovinAnalyticsCollector/Core', '3.18.1'
  pod 'BitmovinAnalyticsCollector/BitmovinPlayer', '3.18.1'
  pod 'BitmovinAnalyticsCollector/AVPlayer', '3.18.1'
end

def bitmovin_player
  pod 'BitmovinPlayer', '3.99.0'
end

target 'AVFoundationPlayerBasicSetup' do
  project 'AVFoundationPlayerBasicSetup/AVFoundationPlayerBasicSetup.xcodeproj'
  analytics_collector
end

target 'BitmovinPlayerPlaylist' do
  project 'BitmovinPlayerPlaylist/BitmovinPlayerPlaylist.xcodeproj'
  bitmovin_player
  analytics_collector
end
