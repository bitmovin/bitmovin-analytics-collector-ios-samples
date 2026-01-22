import SwiftUI
import THEOplayerCollector
import THEOplayerSDK
import CoreCollector

struct ContentView: View {
    private let player: THEOplayer
    private let collector: THEOplayerCollectorApi

    init() {
        // Create player configuration
        // Initialize THEOplayer
        let configBuilder = THEOplayerConfigurationBuilder()
        // License key left empty for POC - will use whitelisted sources
        configBuilder.license = "sZP7IYe6T6fz0SU1ISei36kKClBiFSaLCDB-CKCk0mkK0uarCo0r0lbt3Kh6FOPlUY3zWokgbgjNIOf9flxg0LIlIl5zFS5LTDh-3uaZ0Zzr3LaZFSA60SRL3oCZ3Sg1ImfVfK4_bQgZCYxNWoryIQXzImf90SRi0Sat3l5i0u5i0Oi6Io4pIYP1UQgqWgjeCYxgflEc3LC_0L0i0Lhk0LbiFOPeWok1dDrLYtA1Ioh6TgV6v6fVfKcqCoXVdQjLUOfVfGxEIDjiWQXrIYfpCoj-fgzVfKxqWDXNWG3ybojkbK3gflNWf6E6FOPVWo31WQ1qbta6FOPzdQ4qbQc1sD4ZFK3qWmPUFOPLIQ-LflNWfKgqbZPUFOPLIDreYog-bwPgbt3NWo_6TGxZUDhVfKIgCYxkbK4LflNWYYz"
        player = THEOplayer(configuration: configBuilder.build())


        // Create a CustomData object with acts as fallback if not explicitly specified for a Source
        let customData = CustomData(
            customData1: "analytics",
            customData2: "sample"
        )

        // Configure DefaultMetadata used for the Collector instance
        let defaultMetadata = DefaultMetadata(
            customUserId: "public-theoplayer-analytics-sample",
            customData: customData
        )

        // Create analytics configuration with your analytics license key
        let analyticsConfig = AnalyticsConfig(
            licenseKey: "17e6ea02-cb5a-407f-9d6b-9400358fbcc0"
        )

        // Create collector with analytics config and default metadata
        collector = THEOplayerCollectorFactory.create(
            config: analyticsConfig,
            defaultMetadata: defaultMetadata
        )

        // Attach collector to player
        collector.attach(to: player)
    }

    var body: some View {
        VStack {
            ZStack {
                Color.black

                THEOplayerViewWrapper(player: player)
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

            // Set source metadata on the collector
            collector.sourceMetadata = sourceMetadata

            // Create THEOplayer source
            let source = "https://cdn.theoplayer.com/video/big_buck_bunny/big_buck_bunny.m3u8"
            let typedSource = TypedSource(src: source, type: "application/x-mpegurl")
            player.source = SourceDescription(source: typedSource)
        }
        .onDisappear {
            collector.detach()
            player.stop()
        }
    }
}

// SwiftUI wrapper for THEOplayer
struct THEOplayerViewWrapper: UIViewRepresentable {
    let player: THEOplayer

    func makeUIView(context: Context) -> UIView {
        let containerView = UIView()
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        player.addAsSubview(of: containerView)
        return containerView
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        player.frame = uiView.bounds
    }
}

#Preview {
    ContentView()
}
