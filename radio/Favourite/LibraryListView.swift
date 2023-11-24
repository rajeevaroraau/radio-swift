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
    
    @Query var favouriteStations: [PersistableStation]
    var body: some View {
        List {
            ForEach(favouriteStations) { libraryStation in
                Button {             
                    Task {
                        await PlayingStation.shared.setStation(libraryStation.station, faviconCached: libraryStation.faviconData)
                    }
                    AudioController.shared.play()
                } label: {
                    StationRowView(faviconCached: nil, station: libraryStation.station)
                    
                }
                .buttonStyle(.plain)
                .foregroundStyle(.primary)
            }
            .onDelete  { indexSet in
                
                for index in indexSet {
                    modelContext.delete(favouriteStations[index])
                }
                
            }
        }
    }
}


