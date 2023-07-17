platform :ios, '14.0'
use_frameworks!

source 'https://cdn.cocoapods.org'
source 'https://github.com/bitmovin/cocoapod-specs.git'

workspace 'BitmoviniOSCollectorSamples'

def bitmovin_player
  pod 'BitmovinPlayer', '3.41.0'
end

def analytics_collector
  pod 'BitmovinAnalyticsCollector/Core', '3.0.0-a.7'
  pod 'BitmovinAnalyticsCollector/BitmovinPlayer', '3.0.0-a.7'
  pod 'BitmovinAnalyticsCollector/AVPlayer', '3.0.0-a.7'
end

target 'BasicSetup' do
  project 'BasicSetup/BasicSetup.xcodeproj'
  bitmovin_player
  analytics_collector
end

target 'BasicAVFoundationPlayerSetup' do
  project 'BasicAVFoundationPlayerSetup/BasicAVFoundationPlayerSetup.xcodeproj'
  analytics_collector
end