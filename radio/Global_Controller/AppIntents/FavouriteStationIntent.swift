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
        

        
        print("Found a persisted station in PlayingStation.station: \(PlayingStation.shared.extendedStation.stationBase.name)")
        
        let extendedStationLocal = ExtendedStation(stationBase: PlayingStation.shared.extendedStation.stationBase)
        extendedStationLocal.setStationWithFetchingFavicon(PlayingStation.shared.extendedStation.stationBase, faviconCached: PlayingStation.shared.extendedStation.faviconData)

        print("StationTemp created")
        SwiftDataContainers.shared.container.mainContext.insert(extendedStationLocal)
        return .result()
       
    }
  
}







