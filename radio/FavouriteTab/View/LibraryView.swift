//
//  LibraryView.swift
//  Radio
//
//  Created by Marcin Wolski on 09/12/2023.
//

import SwiftUI
import SwiftData

struct LibraryView: View {
    @Environment(\.modelContext) var modelContext
    @Query var favoriteStations: [ExtendedStation]
    
    let columns = [
        GridItem(.adaptive(minimum: 150, maximum: 180), spacing: 12),
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(favoriteStations) { favoriteStation in
                    Button {
                        handleStationTap(favoriteStation: favoriteStation)
                    } label: {
                        LibraryTileView(favoriteStation: favoriteStation)
                    }
                        .contextMenu() {
                            Button("Unfavorite", systemImage: "star.slash") {
                                modelContext.delete(favoriteStation)
                                do {
                                    try  modelContext.save()
                                } catch {
                                    print("Cannot delete station")
                                }
                            }
                        } preview: {
                            Button {
                                handleStationTap(favoriteStation: favoriteStation)
                            } label: {
                                LibraryTileView(favoriteStation: favoriteStation)
                            }
                        }
                }

            }
            

            
        }
        .contentMargins(.bottom, 96, for: .automatic)
        .padding(.horizontal, 8)
    }
}

extension LibraryView {
    func handleStationTap(favoriteStation: ExtendedStation)  {

        
        Task {
            await MainActor.run {
                PlayingStation.shared.extendedStation.setStationWithFetchingFavicon(favoriteStation.stationBase, faviconCached: favoriteStation.faviconData)
            }
            await AudioController.shared.playWithSetup()
        }     
    }
}
