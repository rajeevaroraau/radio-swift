//
//  CachingManager.swift
//  Radio
//
//  Created by Marcin Wolski on 18/02/2024.
//

import Foundation
import SwiftData

class CachingManager {
    
    static let shared = CachingManager()

    func toggleFavorite(stationBase: StationBase) async {
        do {
            var extendedCachedStations = try await SwiftDataContainers.shared.container.mainContext.fetch(FetchDescriptor<ExtendedStation>())
            // IS IT CACHED
            if let extendedCachedStation = extendedCachedStations.first(where: {$0.stationBase == stationBase }) {
                // IS IT CURRENTLY PLAYING
                if extendedCachedStation.favourite == false {
                    print("Trying to add to favorites a currently playing station")
                    await addToFavorites(stationBaseToInsert: extendedCachedStation.stationBase)
                } else {
                    print("The station is already a favorite, trying to delete...")
                    await removeFromFavorites(extendedStationToUnfavorite: extendedCachedStation)
                }
            } else {
                print("Not cached station found, trying to add to favorites...")
                await addToFavorites(stationBaseToInsert: stationBase)
            }
        } catch {
            print("Cannot toggle favorite")
        }
}

    func removeFromFavorites(extendedStationToUnfavorite: ExtendedStation) async {
        extendedStationToUnfavorite.favourite = false
        if PlayingStationManager.shared.currentlyPlayingExtendedStation != extendedStationToUnfavorite {
            await SwiftDataContainers.shared.container.mainContext.delete(extendedStationToUnfavorite)
            print("Deleted station from cache")
        }
    }

    func addToFavorites(stationBaseToInsert: StationBase) async {
        do {
            var extendedCachedStations = try await SwiftDataContainers.shared.container.mainContext.fetch(FetchDescriptor<ExtendedStation>())
            var isAlreadyCached = false
            print("Starting to loop on cached stations...")
            for extendedCachedStation in extendedCachedStations {
                if extendedCachedStation.stationBase == stationBaseToInsert {
                    isAlreadyCached = true
                    print("It is a cached station indeed!")
                    if extendedCachedStation.favourite == false { extendedCachedStation.favourite = true; print("Added to favorites") }
                    break
                }
            }
            if isAlreadyCached == false {
                print("The station wasn't cached...")
                let extendedStationToFavorite = ExtendedStation(stationBase: stationBaseToInsert)
                await SwiftDataContainers.shared.container.mainContext.insert(extendedStationToFavorite)
                extendedStationToFavorite.favourite = true
                print("Favorited the station")
            }
        } catch {
            print("Error - cannot add to favorites")
        }
    }
}
