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
            print("No station in FavouriteStation App Intent's perform()");
            return .result()
        }
        
        print("Found a persisted station in PlayingStation.station: \(stationPlaying.name)")
        
        let stationTemp = PersistableStation(station: stationPlaying)
        Task {
            await stationTemp.fetchStation()
        }

        print("StationTemp created")
        SwiftDataContainers.shared.container.mainContext.insert(stationTemp)
        return .result()
       
    }
  
}







