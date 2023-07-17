//
//  ContentView.swift
//  BasicSetup
//
//  Created by Thomas Sablattnig on 17.07.23.
//

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

        // Create collector config
        let analyticsConfig = AnalyticsConfig(licenseKey: "<Your License Key>")

        // Create Collector
        collector = BitmovinPlayerCollectorFactory.create(config: analyticsConfig)
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
            player.load(sourceConfig: sourceConfig)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
