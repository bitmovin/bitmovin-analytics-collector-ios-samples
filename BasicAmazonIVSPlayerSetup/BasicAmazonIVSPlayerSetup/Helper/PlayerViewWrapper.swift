import AmazonIVSPlayer

class PlayerViewWrapper {
    let playerView: PlayerView
    private let ivsPlayerView: IVSPlayerView

    var player: IVSPlayer? {
        get {
            ivsPlayerView.player
        }
        set {
            ivsPlayerView.player = newValue
        }
    }

    init() {
        self.ivsPlayerView = IVSPlayerView(frame: .zero)
        self.playerView = PlayerView(playerUIView: self.ivsPlayerView)
    }
}
