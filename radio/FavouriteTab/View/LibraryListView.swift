//
//  LibraryListView.swift
//  Radio
//
//  Created by Marcin Wolski on 07/10/2023.
//

import SwiftUI
import SwiftData

struct LibraryListView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var favoriteStations: [PersistableStation]
    var body: some View {
        List {
            ForEach(favoriteStations) { favoriteStation in
                Button {             
                    PlayingStation.shared.setStation(favoriteStation.station, faviconCached: favoriteStation.faviconData)
                    AudioController.shared.playWithSetup()
                } label: {
                    StationRowView(faviconCached: nil, station: favoriteStation.station)
                    
                }
                .buttonStyle(.plain)
                .foregroundStyle(.primary)
            }
            .onDelete  { indexSet in
                
                for index in indexSet {
                    modelContext.delete(favoriteStations[index])
                }
                
            }
        }
    }
}


