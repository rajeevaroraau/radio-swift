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
    @State var stationsModel = StationsViewController()


    init() {
        if let stationToPlay = try? SwiftDataContainers.shared.container.mainContext.fetch(FetchDescriptor<PlayingStation>()).last {
            guard let station = stationToPlay.station else {
                print("No station in stationToPlay");
                return
            }
            
            PlayingStation.shared.setStation(station, faviconCached: stationToPlay.faviconData)
            print("Reverted to the latest station: \(PlayingStation.shared.station?.name ?? "EROR")")
        } else {
            print("No station to revert to")
        }
        
    }
}

extension radioApp {
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(SwiftDataContainers.shared.container)
        .environment(stationsModel)
    }
}
