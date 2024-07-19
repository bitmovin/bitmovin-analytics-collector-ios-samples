import SwiftUI
import BitmovinCollector
import BitmovinPlayer
import CoreCollector

// You can find your player license key on the player license dashboard:
// https://bitmovin.com/dashboard/player/licenses
private let playerLicenseKey = "<PLAYER_LICENSE_KEY>"
// You can find your analytics license key on the analytics license dashboard:
// https://bitmovin.com/dashboard/analytics/licenses
private let analyticsLicenseKey = "<ANALYTICS_LICENSE_KEY>"

struct ContentView: View {
    private let player: Player
    private let playerViewConfig: PlayerViewConfig
    private let ssaiAdProvider: SsaiInformationProvider = StaticSsaiInformationProvider()
    private let bitmovinAdScheduler: BitmovinPlayerSsaiAdScheduler
    private var sourceConfig: SourceConfig {
        guard let streamUrl = URL(string: "https://bitmovin-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8") else {
            fatalError("Invalid URL")
        }

        return SourceConfig(url: streamUrl, type: .hls)
    }

    init() {
        // Create player configuration
        let playerConfig = PlayerConfig()
        playerConfig.tweaksConfig.timeChangedInterval = 0.1

        // Set your player license key on the player configuration
        playerConfig.key = playerLicenseKey

        // Create a CustomData object with acts as fallback if not explicitly specified for a Source
        let customData = CustomData(
            customData1: "analytics",
            customData2: "sample"
        )

        // Configure DefaultMetadata used for the Collector instance
        let defaultMetadata = DefaultMetadata(
            customUserId: "public-player-analytics-sample",
            customData: customData
        )

        // Create analytics configuration with your analytics license key
        let analyticsConfig = AnalyticsConfig(
            licenseKey: analyticsLicenseKey
        )

        // Create player based on player and analytics configurations with DefaultMetadata set
        player = PlayerFactory.createPlayer(
            playerConfig: playerConfig,
            analytics:
                .enabled(
                    analyticsConfig: analyticsConfig,
                    defaultMetadata: defaultMetadata
                )
        )

        bitmovinAdScheduler = BitmovinPlayerSsaiAdScheduler(player: player, collector: player.analytics!)

        // Load information about the current session and the ads that are injected into the stream
        let ads = ssaiAdProvider.fetchAdInformation()

        // Schedule the ads to automatically start analytics tracking
        bitmovinAdScheduler.scheduleAds(ads: ads)

        // Create player view configuration
        playerViewConfig = PlayerViewConfig()
    }

    var body: some View {
        VideoPlayerView(
                player: player,
                playerViewConfig: playerViewConfig
            )
        .background(.black)
        .padding()
        .onAppear {
            // Create a Source specific CustomData object will only be used for one source
            let customData = CustomData(
                customData3: "Free-running action"
            )

            // Create a Source specific SourceMetadata object with a specific `CustomData` object
            let sourceMetadata = SourceMetadata(
                title: "Art Of Motion",
                path: "root",
                customData: customData
            )

            // Create a Source with specific Analytics metadata
            let source = SourceFactory.createSource(
                from: sourceConfig,
                sourceMetadata: sourceMetadata
            )

            player.load(source: source)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
