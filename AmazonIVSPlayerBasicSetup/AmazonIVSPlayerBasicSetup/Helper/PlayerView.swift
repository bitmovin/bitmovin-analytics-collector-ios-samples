import SwiftUI
import AmazonIVSPlayer

struct PlayerView: UIViewRepresentable {
    private let playerUIView: IVSPlayerView
    init(playerUIView: IVSPlayerView) {
        self.playerUIView = playerUIView
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerView>) {
    }

    func makeUIView(context: Context) -> UIView {
        return playerUIView
    }
}
