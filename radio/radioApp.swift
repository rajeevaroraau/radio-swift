//
//  radioApp.swift
//  radio
//
//  Created by Marcin Wolski on 06/10/2023.
//

import SwiftUI
import SwiftData

@main
struct radioApp: App {
    init() {
        
        let stationsModel = StationsController()
        let playingStation = PlayingStation()
        let audioModel = AudioModel(playingStation: playingStation)
        
        _stationsModel = State(initialValue: stationsModel)
        _playingStation = State(initialValue: playingStation)
        _audioModel = State(initialValue: audioModel)

    }

    @State private var audioModel: AudioModel
    @State var stationsModel: StationsController
    @State private var playingStation: PlayingStation
}

extension radioApp {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: CachedStation.self)
        
        .environment(audioModel)
        .environment(stationsModel)
        .environment(playingStation)
    }
        
}
