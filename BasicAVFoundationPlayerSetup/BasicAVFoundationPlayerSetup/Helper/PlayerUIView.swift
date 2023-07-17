import SwiftUI
import AVFoundation

class PlayerUIView: UIView {
    private let playerLayer = AVPlayerLayer()
    private var _player: AVPlayer?
    var player: AVPlayer? {
        get {
            _player
        }
        set {
            playerLayer.player = newValue
            _player = newValue
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        layer.addSublayer(playerLayer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}
