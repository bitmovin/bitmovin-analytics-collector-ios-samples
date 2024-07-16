import SwiftUI
import BitmovinCollector
import BitmovinPlayer
import CoreCollector

struct ContentView: View {
    private let player: Player
    private let playerViewConfig: PlayerViewConfig
    private var sourceConfig: SourceConfig {
        guard let streamUrl = URL(string: "https://bitmovin-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8") else {
            fatalError("Invalid URL")
        }

        return SourceConfig(url: streamUrl, type: .hls)
    }

    init() {
        // Create player configuration
        let playerConfig = PlayerConfig()

        // Set your player license key on the player configuration
        playerConfig.key = "7ef40b69-f1c0-4c2c-8212-32b973204800"

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
            licenseKey: "53b1ad1f-1ffa-4e53-a8fb-02c16439d2f8"
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

        // Create player view configuration
        playerViewConfig = PlayerViewConfig()
    }

    var body: some View {
        VStack {
            ZStack {
                Color.black

                VideoPlayerView(
                    player: player,
                    playerViewConfig: playerViewConfig
                )
            }
        }
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
