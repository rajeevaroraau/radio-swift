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
import OSLog

struct FavouriteStation: AppIntent {
    static var title: LocalizedStringResource = "Favourite"
    
    @MainActor
    func perform() async throws -> some IntentResult {
        Logger.favouriteStationIntent.info("Start \(Self.title.locale)")
        Logger.favouriteStationIntent.info("Found a persisted station in PlayingStation.station: \(PlayingStation.shared.currentlyPlayingExtendedStation?.stationBase.name ?? "Nothing")")
        guard let currentlyPlayingExtendedStation = PlayingStation.shared.currentlyPlayingExtendedStation else {
            return .result()
        }
        currentlyPlayingExtendedStation.favourite = true
        Persistance.shared.container.mainContext.insert(currentlyPlayingExtendedStation)
        return .result()
    }
}







