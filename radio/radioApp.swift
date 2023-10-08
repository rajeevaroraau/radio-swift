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
    @State private var playingStation = PlayingStation()
    @State private var audioModel = AudioModel()
    @Bindable var stationsModel = StationsViewModel()
   
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
