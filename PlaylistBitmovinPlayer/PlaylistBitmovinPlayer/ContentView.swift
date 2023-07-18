import SwiftUI
import BitmovinPlayer
import BitmovinCollector
import CoreCollector

struct ContentView: View {
    private let player: Player
    private let collector: BitmovinPlayerCollectorAPI
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

        // Create player based on player config
        player = PlayerFactory.create(playerConfig: playerConfig)

        // Create player view configuration
        playerViewConfig = PlayerViewConfig()

        // Create analytics config
        let analyticsConfig = AnalyticsConfig(licenseKey: "<Your License Key>")

        // Create analytics collector
        collector = BitmovinPlayerCollectorFactory.create(config: analyticsConfig)
    }

    private func loadPlaylistWithMetadata() {
        let playlistOptions = PlaylistOptions(preloadAllSources: false)

        // source 1 setup
        let redbullSource = SourceFactory.create(from: SourceConfig(url: URL(string: "https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8")!, type: .hls))

        // apply information about the video
        let redbullMetadata = SourceMetadata(
            videoId: "redbull_art_of_motion",
            title: "Redbull - Art of Motion",
            path: "vod/redbull",
            isLive: false
        )

        // connect the metadata with the source
        collector.apply(
            sourceMetadata: redbullMetadata,
            for: redbullSource
        )

        // source 2 setup
        let sintelSource = SourceFactory.create(from: SourceConfig(url: URL(string: "https://bitmovin-a.akamaihd.net/content/sintel/hls/playlist.m3u8")!, type: .hls))

        // apply information about the video
        let sintelMetadata = SourceMetadata(
            videoId: "sintel",
            title: "Sintel",
            path: "vod/sintel",
            isLive: false
        )

        // connect the metadata with the source
        collector.apply(
            sourceMetadata: sintelMetadata,
            for: sintelSource
        )

        let playlist = PlaylistConfig(
            sources: [redbullSource, sintelSource],
            options: playlistOptions
        )

        player.load(playlistConfig: playlist)
        player.play()
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

            // attach collector before source load
            collector.attach(to: player)

            // load source
            loadPlaylistWithMetadata()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
