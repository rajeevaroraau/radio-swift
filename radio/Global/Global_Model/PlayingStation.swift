//
//  PlayingStation.swift
//  Radio
//
//  Created by Marcin Wolski on 06/10/2023.
//

import Foundation
import SwiftUI
import SwiftData
import Observation
import OSLog

@Observable
class PlayingStation {
    static let shared = PlayingStation()
    var currentlyPlayingExtendedStation: ExtendedStation?
    init() {
        Task {
            await setCurrentlyPlayingExtendedStationFromCache()
        }
    }
    
    @MainActor
    func setCurrentlyPlayingExtendedStationFromCache() async {
        do {
            let cachedExtendedStations = try  Persistance.shared.container.mainContext.fetch(FetchDescriptor<ExtendedStation>())
            for cachedExtendedStation in cachedExtendedStations {
                if cachedExtendedStation.currentlyPlaying {
                    currentlyPlayingExtendedStation = cachedExtendedStation
                    break
                }
                if currentlyPlayingExtendedStation == nil {
                    Logger.playingStationManager.notice("There was no played cached stations")
                } else {
                    self.currentlyPlayingExtendedStation = nil
                }
            }
        } catch {
            self.currentlyPlayingExtendedStation = nil
        }
    }
    
    @MainActor
    func persistExtendedStation(extendedStation: ExtendedStation) async {
        Logger.playingStationManager.info("Trying to persist a station")
        Persistance.shared.container.mainContext.insert(extendedStation)
        do {
            try Persistance.shared.container.mainContext.save()
            Logger.playingStationManager.info("Persisted \(extendedStation.stationBase.name)")
        } catch {
            fatalError("Cannot cache \(extendedStation.stationBase.name)")
        }
    }
    
    func setCurrentlyPlayingExtendedStation(_ extendedStation: ExtendedStation) async {
        if currentlyPlayingExtendedStation != extendedStation {
            await persistExtendedStation(extendedStation: extendedStation)
            await MainActor.run {
                Logger.playingStationManager.info("Chaning currentlyPlaying item")
                currentlyPlayingExtendedStation?.currentlyPlaying = false
                currentlyPlayingExtendedStation = nil
                extendedStation.currentlyPlaying = true
                currentlyPlayingExtendedStation = extendedStation
                Task {
                    await extendedStation.setFavicon(extendedStation.faviconData)
                }
                
                Logger.playingStationManager.info("PlayingStation has been replaced by \(extendedStation.stationBase.name)")
            }
        } else {
            Logger.playingStationManager.notice("No need to replace PlayingStation")
        }

       
    }
}







