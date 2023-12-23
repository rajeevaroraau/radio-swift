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
        do {
            if let extendedStationToPlay = try SwiftDataContainers.shared.container.mainContext.fetch(FetchDescriptor<PlayingStation>()).last?.extendedStation {
                print("\(extendedStationToPlay.stationBase.name)")
print("Inside the loop")
                PlayingStation.shared.extendedStation.setStationWithFetchingFavicon(extendedStationToPlay.stationBase, faviconCached: extendedStationToPlay.faviconData)
                
                
                print("Reverted to the latest station: \(PlayingStation.shared.extendedStation.stationBase.name)")
            } else {
                print("No station to revert to")
                SwiftDataContainers.shared.container.mainContext.insert(PlayingStation.shared.self)
                try SwiftDataContainers.shared.container.mainContext.save()

            }
        } catch {
            print(error.localizedDescription)
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
