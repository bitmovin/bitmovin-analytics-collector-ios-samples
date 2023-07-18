//
//  ContentView.swift
//  BasicAmazonIVSPlayerSetup
//
//  Created by Thomas Sablattnig on 18.07.23.
//

import SwiftUI
import AmazonIVSPlayer
import CoreCollector
import AmazonIVSCollector

struct ContentView: View {
    private let player: IVSPlayer
    private let wrapper: PlayerViewWrapper
    private let collector: AmazonIVSPlayerCollectorAPI

    init() {
        // Create player
        self.player = IVSPlayer()

        // Custom Wrapper for swift ui display
        self.wrapper = PlayerViewWrapper()
        wrapper.player = player

        // Create analytics config
        let config = AnalyticsConfig(licenseKey: "<Your license key>")

        // Create analytics collector
        collector = AmazonIVSPlayerCollectorFactory.create(config: config)
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
            player.load(URL(string: "https://fcc3ddae59ed.us-west-2.playback.live-video.net/api/video/v1/us-west-2.893648527354.channel.DmumNckWFTqz.m3u8")!)
            player.play()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
