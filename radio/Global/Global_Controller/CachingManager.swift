//
//  CachingManager.swift
//  Radio
//
//  Created by Marcin Wolski on 18/02/2024.
//

import Foundation
import SwiftData
import OSLog
class CachingManager {
    let logger = Logger(subsystem: "Radio", category: "CachingManager")
    static let shared = CachingManager()
    
    @MainActor func findExtendedStation(stationBase: StationBase) -> ExtendedStation? {
        do {
            let extendedCachedStations = try  Persistance.shared.container.mainContext.fetch(FetchDescriptor<ExtendedStation>())
            if let extendedCachedStation = extendedCachedStations.first(where: {$0.stationBase == stationBase }) {
                return extendedCachedStation
            }
            return nil
            
        } catch {
            return nil
        }
        
    }
    
    @MainActor
    func toggleFavorite(_ stationBase: StationBase) async {
        if let extendedStation = findExtendedStation(stationBase: stationBase) {
            // PLAYING FROM FAVORITED
            if !extendedStation.favourite {
                logger.notice("Trying to add to favorites a currently playing station")
                await addToFavorites(extendedStation.stationBase)
            } else {
                logger.notice("The station is already a favorite, trying to delete...")
                await removeFromFavorites(extendedStationToUnfavorite: extendedStation)
            }
        } else {
            // PLAYING, NOT FAVORITED YET
            logger.notice("Not cached station found, trying to add to favorites...")
            await addToFavorites(stationBase)
        }
        
    }
    
    func removeFromFavorites(extendedStationToUnfavorite: ExtendedStation) async {
        await MainActor.run { extendedStationToUnfavorite.favourite = false }
        if PlayingStation.shared.currentlyPlayingExtendedStation != extendedStationToUnfavorite {
            await MainActor.run {
                Persistance.shared.container.mainContext.delete(extendedStationToUnfavorite)
                try? Persistance.shared.container.mainContext.save()
            }
            logger.notice("Deleted station from cache")
        }
    }
    
    func addToFavorites(_ stationBase: StationBase) async {
        let result = await isBaseStationOld(stationBase)
        if  result.isOld {
            // the station isn't new
            guard let extendedStation = result.extendedStation else { return }
            extendedStation.favourite = true
        } else {
            // "The station is not playing and wasn't cached..."
            let extendedStationToFavorite = ExtendedStation(stationBase: stationBase, faviconData: nil)
            await MainActor.run {
                Persistance.shared.container.mainContext.insert(extendedStationToFavorite)
            }
            await extendedStationToFavorite.setFavicon(nil)
            extendedStationToFavorite.favourite = true
            
            logger.notice("Favorited the station")
        }
    }
    
    func isBaseStationOld(_ stationBase: StationBase) async -> (isOld: Bool, extendedStation: ExtendedStation?) {
        var isOld = false
        var extendedStation: ExtendedStation? = nil
        if let array = try? await Persistance.shared.container.mainContext.fetch(FetchDescriptor<ExtendedStation>()) {
            for i in array {
                if i.stationBase == stationBase {
                    isOld = true
                    extendedStation = i
                    break
                }
            }
        }
        return (isOld, extendedStation)
    }
}
