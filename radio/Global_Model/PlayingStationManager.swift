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

@Observable
class PlayingStationManager {
    static let shared = PlayingStationManager()
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
                    print("There was no played cached stations")
                }
                else {
                    self.currentlyPlayingExtendedStation = nil
                    print("No extendedStationCached found")
                }
            }
        } catch {
            self.currentlyPlayingExtendedStation = nil
        }
    }
    
    func setCurrentlyPlayingExtendedStation(_ extendedStation: ExtendedStation) async {
        await MainActor.run {
            Persistance.shared.container.mainContext.insert(extendedStation)
            currentlyPlayingExtendedStation?.currentlyPlaying = false
            extendedStation.currentlyPlaying = true
        }
        currentlyPlayingExtendedStation = extendedStation
        await extendedStation.setFavicon(extendedStation.faviconData)
    }
}







