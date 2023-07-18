import AVFoundation

class PlayerViewWrapper {
    let playerView: PlayerView
    private let playerUIView: PlayerUIView

    var player: AVPlayer? {
        get {
            playerUIView.player
        }
        set {
            playerUIView.player = newValue
        }
    }

    init() {
        self.playerUIView = PlayerUIView(frame: .zero)
        self.playerView = PlayerView(playerUIView: self.playerUIView)
    }
}
