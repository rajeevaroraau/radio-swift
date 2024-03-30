//
//  CacheManager.swift
//  Radio
//
//  Created by Marcin Wolski on 18/02/2024.
//

import Foundation
import SwiftData

@MainActor
@Model
class CacheManager {
    static let shared = CacheManager()
    
    var favoriteExtendedStations: [ExtendedStation] = []
    var currentPlayingExtendedStation: ExtendedStation?
    
    private init() {}
    
    func addToFavorites(stationBase: StationBase) {
        // Add station to favorites cache
         let extendedStation = ExtendedStation(stationBase: stationBase)
        favoriteExtendedStations.append(extendedStation)
        
        // Optionally, synchronize with Core Data
        // CoreDataHelper.saveFavorite(station: station)
    }
    
    func removeFromFavorites(stationBase: StationBase) {
        // Remove station from favorites cache
        if let index = favoriteExtendedStations.firstIndex(where: { $0.stationBase.name == stationBase.name }) {
            favoriteExtendedStations.remove(at: index)
        }
        // Optionally, synchronize with Core Data
        // CoreDataHelper.removeFavorite(station: station)
    }
    
    func setCurrentPlayingStation(stationExtendedOrNot: Any) {
        if let extendedStation = stationExtendedOrNot as? ExtendedStation {
            currentPlayingExtendedStation = extendedStation
        } else if let stationBase = stationExtendedOrNot as? StationBase {
            let extendedStation = ExtendedStation(stationBase: stationBase)
            currentPlayingExtendedStation = extendedStation
        } else {
            
        }
    }

    
    func clearCurrentPlayingStation() {
        // Clear current playing station
        currentPlayingExtendedStation = nil
        // Optionally, synchronize with Core Data
        // CoreDataHelper.removeCurrentPlayingStation()
    }
}
