//
//  AppIntents.swift
//  Radio
//
//  Created by Marcin Wolski on 10/11/2023.
//

import Foundation
import AppIntents
import SwiftData
import SwiftUI

struct FavouriteStation: AppIntent {
    static var title: LocalizedStringResource = "Favourite"
    @MainActor
    func perform() async throws -> some IntentResult {
        print("Start \(Self.title.locale)")
        
        guard let stationPlaying = PlayingStation.shared.station else {
            print("No")
            return .result()
        }
        
        print("Found a persisted station in PlayingStation.station")
        
        let stationTemp = PersistableStation(station: stationPlaying)
//        Task {
//            await stationTemp.fetchStation()
//        }
        
       
        
        print("StationTemp created")

//        let modelContext = ModelContext(modelContainer)
//        print("modelContext created")
//
//        modelContext.insert(temporaryPersistableStation)
//        print("Insrted!")
//
//        do {
//            try modelContext.save()
//            print("Favourite Done!")
//            return .result()
//        } catch {
//            print("Bad")
//        }
        Container.shared.container.mainContext.insert(stationTemp)
        return .result()
       
    }
  
}







