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
    
    @Query var favoriteStations: [ExtendedStation]
    var body: some View {
        List {
            ForEach(favoriteStations) { favoriteStation in
                Button {
                        
                    PlayingStation.shared.extendedStation.setStationWithFetchingFavicon(favoriteStation.stationBase, faviconCached: favoriteStation.faviconData)
                        
                        Task {
                            await AudioController.shared.playWithSetup()
                        }
                    
                } label: {

                    StationRowView(faviconCached: favoriteStation.faviconUIImage, station: favoriteStation.stationBase)
                    
                    
                    
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


