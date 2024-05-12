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
        Logger.favouriteStationIntent.info("Found a persisted station in PlayingStation.station: \(PlayingStation.shared.currentlyPlayingRichStation?.stationBase.name ?? "Nothing")")
        guard let currentlyPlayingRichStation = PlayingStation.shared.currentlyPlayingRichStation else {
            return .result()
        }
        currentlyPlayingRichStation.favourite = true
        Persistance.shared.container.mainContext.insert(currentlyPlayingRichStation)
        return .result()
    }
    
}







