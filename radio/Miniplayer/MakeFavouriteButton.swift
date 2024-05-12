//
//  FavouriteButton.swift
//  Radio
//
//  Created by Marcin Wolski on 01/11/2023.
//

import SwiftUI
import SwiftData

struct MakeFavouriteButton: View {
    @Query(filter: #Predicate<RichStation> { richStation in richStation.currentlyPlaying } ) var currentlyPlayingRichStation: [RichStation]
    @Query(filter: #Predicate<RichStation> { richStation in richStation.favourite } ) var favoriteRichStations: [RichStation]
    
    var body: some View {
        Button("Favourite", systemImage: favoriteRichStations.contains(where: { $0.stationBase == currentlyPlayingRichStation.first?.stationBase }) ? "star.circle.fill" : "star.circle") {
            Task {
                guard let currentlyPlayingRichStation = currentlyPlayingRichStation.first else { return }
                await CachingManager.shared.toggleFavorite(currentlyPlayingRichStation.stationBase)
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



