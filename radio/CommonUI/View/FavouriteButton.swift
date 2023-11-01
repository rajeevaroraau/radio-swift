//
//  FavouriteButton.swift
//  Radio
//
//  Created by Marcin Wolski on 01/11/2023.
//

import SwiftUI
import SwiftData

struct FavouriteButton: View {
    @Environment(PlayingStation.self) private var playingStation: PlayingStation
    @Query var favouriteStations: [CachedStation]
    @Environment(\.modelContext) var modelContext
    var body: some View {
        Button("Favourite", systemImage: favouriteStations.contains(where: { $0.station == playingStation.station }) ? "star.circle.fill" : "star.circle") {
            guard let station =  playingStation.station else { return }
            hapticFeedback()
            if let stationToDelete = favouriteStations.first(where: { $0.station == playingStation.station }) {
                modelContext.delete(stationToDelete)
            } else {
                let stationTemp = CachedStation(station: station)
                modelContext.insert(stationTemp)
                
                Task {
                    await stationTemp.fetchStation()
                }
            }
        }
        .contentTransition(.symbolEffect(.replace))
        .symbolRenderingMode(.hierarchical)
        .labelStyle(.iconOnly)
        .foregroundStyle(.white)
        .font(.largeTitle)
        .padding(10)
    }
}


#Preview {
    FavouriteButton()
}
