//
//  ContentView.swift
//  BasicAVFoundationPlayerSetup
//
//  Created by Thomas Sablattnig on 17.07.23.
//

import SwiftUI
import AVFoundation
import AVFoundationCollector
import CoreCollector

struct ContentView: View {
    private let player: AVPlayer
    private let collector: AVPlayerCollectorAPI
    private let wrapper: PlayerViewWrapper
    private let streamUrl = URL(string: "https://bitmovin-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8")

    init() {
        // Create player
        player = AVPlayer()

        // Custom Wrapper for swift ui display
        wrapper = PlayerViewWrapper()
        wrapper.player = player

        // Create analytics config
        let config = AnalyticsConfig(licenseKey: "53b1ad1f-1ffa-4e53-a8fb-02c16439d2f8")

        // Create analytics collector
        collector = AVPlayerCollectorFactory.create(config: config)
    }
    var body: some View {
        VStack {
            wrapper.playerView
        }
        .padding()
        .onAppear() {
            // attach collector before source load
            collector.attach(to: player)

            // load source
            player.replaceCurrentItem(with: AVPlayerItem(url: streamUrl!))
            player.play()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
