//
//  FavouriteButton.swift
//  Radio
//
//  Created by Marcin Wolski on 01/11/2023.
//

import SwiftUI
import SwiftData

struct FavouriteButton: View {
    @Query var favoriteStations: [PersistableStation]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        
        Button("Favourite", systemImage: favoriteStations.contains(where: { $0.station == PlayingStation.shared.station }) ? "star.circle.fill" : "star.circle") {
            guard let station =  PlayingStation.shared.station else {
                print("No station in FavouriteButton");
                return
            }
            if let stationToDelete = favoriteStations.first(where: { $0.station == PlayingStation.shared.station }) {
                modelContext.delete(stationToDelete)
            } else {
                let stationTemp = PersistableStation(station: station)
                modelContext.insert(stationTemp)
                hapticFeedback()

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



