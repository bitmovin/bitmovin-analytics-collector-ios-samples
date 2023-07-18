import SwiftUI
import AVFoundation

struct PlayerView: UIViewRepresentable {
    private let playerUIView: PlayerUIView
    init(playerUIView: PlayerUIView) {
        self.playerUIView = playerUIView
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerView>) {
    }

    func makeUIView(context: Context) -> UIView {
        return playerUIView
    }
}
