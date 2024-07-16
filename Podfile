platform :ios, '14.0'
use_frameworks!

source 'https://cdn.cocoapods.org'
source 'https://github.com/bitmovin/cocoapod-specs.git'

workspace 'BitmoviniOSCollectorSamples'


def analytics_collector
  pod 'BitmovinAnalyticsCollector/Core', '3.7.0'
  pod 'BitmovinAnalyticsCollector/BitmovinPlayer', '3.7.0'
  pod 'BitmovinAnalyticsCollector/AVPlayer', '3.7.0'
  pod 'BitmovinAnalyticsCollector/AmazonIVSPlayer', '3.7.0'
end

def bitmovin_player
  pod 'BitmovinPlayer', '3.64.0'
end

def amazon_ivs_player
  pod 'AmazonIVSPlayer', '1.24.0'
end

target 'AVFoundationPlayerBasicSetup' do
  project 'AVFoundationPlayerBasicSetup/AVFoundationPlayerBasicSetup.xcodeproj'
  analytics_collector
end

target 'AmazonIVSPlayerBasicSetup' do
  project 'AmazonIVSPlayerBasicSetup/AmazonIVSPlayerBasicSetup.xcodeproj'
  analytics_collector
  amazon_ivs_player
end

target 'BitmovinPlayerPlaylist' do
  project 'BitmovinPlayerPlaylist/BitmovinPlayerPlaylist.xcodeproj'
  bitmovin_player
  analytics_collector
end
