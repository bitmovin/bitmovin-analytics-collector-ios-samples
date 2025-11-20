# bitmovin-analytics-collector-ios-samples

This repository contains sample apps which are using the Bitmovin Player iOS SDK.

**Table of Content**

- [bitmovin-analytics-collector-ios-samples](#bitmovin-analytics-collector-ios-samples)
  - [Available Sample Apps](#available-sample-apps)
    - [Basics](#basics)
    - [Playlist](#playlist)
    - [Server-Side Ad Insertion (SSAI)](#server-side-ad-insertion-ssai)
  - [Sample App Setup Instructions](#sample-app-setup-instructions)
    - [Dependency Management](#dependency-management)
    - [Setup Steps](#setup-steps)
    - [License Configuration](#license-configuration)
    - [Sample App Setup Instructions with Bitmovin player](#sample-app-setup-instructions-with-bitmovin-player)
  - [Documentation And Release Notes](#documentation-and-release-notes)
  - [Support](#support)


## Available Sample Apps

### Basics
+  **BitmovinPlayerBasicSetup** Shows how to set up the Analytics collector for the Bitmovin player *(uses SPM)*
+  **AVFoundationPlayerBasicSetup** Shows how to set up the Analytics collector for the AVFoundation player *(uses CocoaPods)*
+  **AmazonIVSPlayerBasicSetup** Shows how to set up the Analytics collector for the Amazon IVS player *(uses CocoaPods)*

### Playlist
+  **BitmovinPlayerPlaylist** Shows how to setup metadata information for multiple sources *(uses CocoaPods)*

### Server-Side Ad Insertion (SSAI)
+  **BitmovinPlayerSSAI** Shows how to track Server-Side Ad Insertion with the Analytics collector *(uses SPM)* 

## Sample App Setup Instructions

### Dependency Management
This repository uses **both CocoaPods and Swift Package Manager (SPM)** for different sample apps:
- **CocoaPods**: AVFoundationPlayerBasicSetup, AmazonIVSPlayerBasicSetup, BitmovinPlayerPlaylist
- **SPM**: BitmovinPlayerBasicSetup, BitmovinPlayerSSAI

### Setup Steps
1. Install Ruby dependencies:
   ```bash
   bundle install
   ```

2. Install CocoaPods dependencies:
   ```bash
   bundle exec pod install --repo-update
   ```

3. Open the workspace (not individual `.xcodeproj` files):
   ```bash
   open BitmoviniOSCollectorSamples.xcworkspace
   ```

   SPM dependencies will be resolved automatically by Xcode when opening the workspace.

### License Configuration
You have to log in to [https://bitmovin.com/dashboard](https://bitmovin.com/dashboard), where you have to add the following bundle identifier of the sample application as an allowed domain under `Analytics -> Licenses`:


    com.bitmovin.analytics.samples.bitmovinplayer.basic
    com.bitmovin.analytics.samples.bitmovinplayer.playlist
    com.bitmovin.analytics.samples.avfoundation.basic
    com.bitmovin.analytics.samples.amazonivs.basic

### Sample App Setup Instructions with Bitmovin player

If you want to run the sample apps for bitmovin player, you also have to add your Bitmovin Player license key to `Info.plist` file as `BitmovinPlayerLicenseKey` or provide it via the `PlayerConfig.key` property.

Also you need to add the bundle indentifier of the samples ([mentioned above](#sample-app-setup-instructions)) as an allowed domain under `Player -> Licenses`

## Documentation And Release Notes
-   More information about how to setup our collector can be found [here](https://developer.bitmovin.com/playback/docs/setup-analytics-ios).
-   The release notes can be found [here](https://developer.bitmovin.com/playback/docs/analytics-collector-ios-releases).

## Support
If you have any questions or issues with this SDK or its examples, or you require other technical support for our services, please login to your Bitmovin Dashboard at https://bitmovin.com/dashboard and [create a new support case](https://bitmovin.com/dashboard/support/cases/create). Our team will get back to you as soon as possible :+1:
