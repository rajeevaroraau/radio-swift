//
//  FavouriteButton.swift
//  Radio
//
//  Created by Marcin Wolski on 01/11/2023.
//

import SwiftUI
import SwiftData

struct FavouriteButton: View {
    @Query(filter: #Predicate<ExtendedStation> { extendedStation in extendedStation.currentlyPlaying } ) var currentlyPlayingExtendedStation: [ExtendedStation]
    @Query(filter: #Predicate<ExtendedStation> { extendedStation in extendedStation.favourite } ) var favoriteExtendedStations: [ExtendedStation]

    
    var body: some View {
        Button("Favourite", systemImage: favoriteExtendedStations.contains(where: { $0.stationBase == currentlyPlayingExtendedStation.first?.stationBase }) ? "star.circle.fill" : "star.circle") {

            Task {
                guard let currentlyPlayingExtendedStation = currentlyPlayingExtendedStation.first else { return }
                await CachingManager.shared.toggleFavorite(stationBase: currentlyPlayingExtendedStation.stationBase)
                
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



