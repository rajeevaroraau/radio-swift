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
    
    static let shared = CachingManager()
    
    @MainActor func findRichStation(stationBase: StationBase) -> RichStation? {
        do {
            let richCachedStations = try  Persistance.shared.container.mainContext.fetch(FetchDescriptor<RichStation>())
            if let richCachedStation = richCachedStations.first(where: {$0.stationBase == stationBase }) {
                return richCachedStation
            }
            return nil
            
        } catch {
            return nil
        }
        
    }
    
    @MainActor
    func toggleFavorite(_ stationBase: StationBase) async {
        if let richStation = findRichStation(stationBase: stationBase) {
            // PLAYING FROM FAVORITED
            if !richStation.favourite {
                Logger.cachingManager.notice("Trying to add to favorites a currently playing station")
                await addToFavorites(richStation.stationBase)
            } else {
                Logger.cachingManager.notice("The station is already a favorite, trying to delete...")
                await removeFromFavorites(richStation)
            }
        } else {
            // PLAYING, NOT FAVORITED YET
            Logger.cachingManager.notice("Not cached station found, trying to add to favorites...")
            await addToFavorites(stationBase)
        }
        
    }
    
    func removeFromFavorites(_ richStationToUnfavorite: RichStation) async {
        await MainActor.run { richStationToUnfavorite.favourite = false }
        if PlayingStation.shared.currentlyPlayingRichStation != richStationToUnfavorite {
            await MainActor.run {
                Persistance.shared.container.mainContext.delete(richStationToUnfavorite)
                try? Persistance.shared.container.mainContext.save()
            }
            Logger.cachingManager.notice("Deleted station from cache")
        }
    }
    
    func addToFavorites(_ stationBase: StationBase) async {
        let result = await isBaseStationOld(stationBase)
        if  result.isOld {
            // the station isn't new
            guard let richStation = result.richStation else { return }
            richStation.favourite = true
        } else {
            // "The station is not playing and wasn't cached..."
            let richStationToFavorite = RichStation(stationBase: stationBase, faviconData: nil)
            await MainActor.run {
                Persistance.shared.container.mainContext.insert(richStationToFavorite)
            }
            await richStationToFavorite.setFavicon(nil)
            richStationToFavorite.favourite = true
            
            Logger.cachingManager.notice("Favorited the station")
        }
    }
    
    func isBaseStationOld(_ stationBase: StationBase) async -> (isOld: Bool, richStation: RichStation?) {
        var isOld = false
        var richStation: RichStation? = nil
        if let array = try? await Persistance.shared.container.mainContext.fetch(FetchDescriptor<RichStation>()) {
            for i in array {
                if i.stationBase == stationBase {
                    isOld = true
                    richStation = i
                    break
                }
            }
        }
        return (isOld, richStation)
    }
    
}
