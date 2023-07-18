# bitmovin-analytics-collector-ios-samples

This repository contains sample apps which are using the Bitmovin Player iOS SDK.

**Table of Content**

- [bitmovin-analytics-collector-ios-samples](#bitmovin-analytics-collector-ios-samples)
  - [Available Sample Apps](#available-sample-apps)
    - [Basics](#basics)
  - [Sample App Setup Instructions](#sample-app-setup-instructions)
    - [Sample App Setup Instructions with Bitmovin player](#sample-app-setup-instructions-with-bitmovin-player)
  - [Documentation And Release Notes](#documentation-and-release-notes)
  - [Support](#support)


## Available Sample Apps

### Basics
+  **BasicBitmovinPlayerSetup** Shows how to set up the Analytics collector for the Bitmovin player
+  **BasicAVFoundationPlayerSetup** Shows how to set up the Analytics collector for the AVFoundation player
+  **BasicAmazonIVSPlayerSetup** Shows how to set up the Analytics collector for the Amazon IVS player

## Sample App Setup Instructions
Please execute `pod install --repo-update` to properly initialize the workspace. 

In addition to that you have to log in to [https://bitmovin.com/dashboard](https://bitmovin.com/dashboard), where you have to add the following bundle identifier of the sample application as an allowed domain under `Analytics -> Licenses`:


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
