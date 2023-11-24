//
//  FavouriteButton.swift
//  Radio
//
//  Created by Marcin Wolski on 01/11/2023.
//

import SwiftUI
import SwiftData

struct FavouriteButton: View {
    @Query var favouriteStations: [PersistableStation]
    @Environment(\.modelContext) var modelContext
    var body: some View {
        Button("Favourite", systemImage: favouriteStations.contains(where: { $0.station == PlayingStation.shared.station }) ? "star.circle.fill" : "star.circle") {
            guard let station =  PlayingStation.shared.station else { return }
            hapticFeedback()
            if let stationToDelete = favouriteStations.first(where: { $0.station == PlayingStation.shared.station }) {
                modelContext.delete(stationToDelete)
            } else {
                let stationTemp = PersistableStation(station: station)
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



