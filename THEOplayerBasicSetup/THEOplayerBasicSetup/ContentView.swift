import SwiftUI
import THEOplayerSDK
import THEOplayerCollector
import CoreCollector

// MARK: - Player Manager

class PlayerManager: ObservableObject {
    var player: THEOplayer?
    var collector: THEOplayerCollectorApi?

    @Published var isPlaying = false

    private let streamUrl = "https://cdn.theoplayer.com/video/big_buck_bunny/big_buck_bunny.m3u8"

    func setupPlayer(in containerView: UIView) {
        guard player == nil else { return }

        let playerConfig = THEOplayerConfigurationBuilder().build()
        let theoplayer = THEOplayer(configuration: playerConfig)

        theoplayer.frame = containerView.bounds
        theoplayer.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        theoplayer.addAsSubview(of: containerView)

        self.player = theoplayer

        setupAnalytics(for: theoplayer)
        setupEventListeners(for: theoplayer)
        loadSource(for: theoplayer)
    }

    private func setupAnalytics(for player: THEOplayer) {
        let analyticsConfig = AnalyticsConfig(
            licenseKey: "53b1ad1f-1ffa-4e53-a8fb-02c16439d2f8"
        )

        let defaultMetadata = DefaultMetadata(
            customUserId: "public-player-analytics-sample",
            customData: CustomData(
                customData1: "analytics",
                customData2: "sample"
            )
        )

        collector = THEOplayerCollectorFactory.create(
            config: analyticsConfig,
            defaultMetadata: defaultMetadata
        )
        collector?.attach(to: player)
    }

    private func setupEventListeners(for player: THEOplayer) {
        _ = player.addEventListener(type: PlayerEventTypes.PLAYING) { [weak self] _ in
            DispatchQueue.main.async { self?.isPlaying = true }
        }
        _ = player.addEventListener(type: PlayerEventTypes.PAUSE) { [weak self] _ in
            DispatchQueue.main.async { self?.isPlaying = false }
        }
        _ = player.addEventListener(type: PlayerEventTypes.ENDED) { [weak self] _ in
            DispatchQueue.main.async { self?.isPlaying = false }
        }
    }

    private func loadSource(for player: THEOplayer) {
        let sourceMetadata = SourceMetadata(
            title: "Big Buck Bunny",
            path: "root",
            customData: CustomData(customData3: "Animation")
        )
        collector?.sourceMetadata = sourceMetadata

        let typedSource = TypedSource(src: streamUrl, type: "application/x-mpegurl")
        player.source = SourceDescription(source: typedSource)
    }

    func togglePlayPause() {
        guard let player = player else { return }
        if isPlaying {
            player.pause()
        } else {
            player.play()
        }
    }

    func seekBackward() {
        guard let player = player else { return }
        player.currentTime = max(0, player.currentTime - 10)
    }

    func seekForward() {
        guard let player = player else { return }
        let duration = player.duration ?? 0
        player.currentTime = min(duration, player.currentTime + 10)
    }

    func cleanup() {
        collector?.detach()
        player?.stop()
    }
}

// MARK: - Content View

struct ContentView: View {
    @StateObject private var playerManager = PlayerManager()

    var body: some View {
        VStack {
            PlayerContainerView(playerManager: playerManager)
                .background(Color.black)

            HStack(spacing: 40) {
                Button(action: playerManager.seekBackward) {
                    Image(systemName: "gobackward.10")
                        .font(.title)
                }

                Button(action: playerManager.togglePlayPause) {
                    Image(systemName: playerManager.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .font(.system(size: 50))
                }

                Button(action: playerManager.seekForward) {
                    Image(systemName: "goforward.10")
                        .font(.title)
                }
            }
            .padding()
        }
        .padding()
        .onDisappear {
            playerManager.cleanup()
        }
    }
}

// MARK: - Player Container

struct PlayerContainerView: UIViewControllerRepresentable {
    @ObservedObject var playerManager: PlayerManager

    func makeUIViewController(context: Context) -> PlayerContainerViewController {
        let viewController = PlayerContainerViewController()
        viewController.playerManager = playerManager
        return viewController
    }

    func updateUIViewController(_ uiViewController: PlayerContainerViewController, context: Context) {}
}

class PlayerContainerViewController: UIViewController {
    var playerManager: PlayerManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard view.bounds.width > 0, view.bounds.height > 0 else { return }

        playerManager?.setupPlayer(in: view)
        playerManager?.player?.frame = view.bounds
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
