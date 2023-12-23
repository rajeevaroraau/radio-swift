//
//  FavouriteButton.swift
//  Radio
//
//  Created by Marcin Wolski on 01/11/2023.
//

import SwiftUI
import SwiftData

struct FavouriteButton: View {
    @Query var favoriteStations: [ExtendedStation]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        
        Button("Favourite", systemImage: favoriteStations.contains(where: { $0.stationBase == PlayingStation.shared.extendedStation.stationBase }) ? "star.circle.fill" : "star.circle") {

            if let stationToDelete = favoriteStations.first(where: { $0.stationBase == PlayingStation.shared.extendedStation.stationBase }) {
                modelContext.delete(stationToDelete)
            } else {
                let stationTemp = ExtendedStation(stationBase: PlayingStation.shared.extendedStation.stationBase, faviconData: PlayingStation.shared.extendedStation.faviconData)
                modelContext.insert(stationTemp)
                
                
                stationTemp.setStationWithFetchingFavicon(PlayingStation.shared.extendedStation.stationBase, faviconCached: PlayingStation.shared.extendedStation.faviconData)
                Task {
                    await hapticFeedback()
                }
            }
        }
        .contentTransition(.symbolEffect(.replace))
        .symbolRenderingMode(.hierarchical)
        .labelStyle(.iconOnly)
        .foregroundStyle(.white)
        .font(.largeTitle)
        .padding(8)
    }
}



