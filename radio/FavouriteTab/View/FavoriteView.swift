//
//  LibraryView.swift
//  Radio
//
//  Created by Marcin Wolski on 09/12/2023.
//

import SwiftUI
import SwiftData

struct FavoriteView: View {
    @Environment(\.modelContext) var modelContext
    @Query(filter: #Predicate<ExtendedStation> { extendedStation in extendedStation.favourite } ) var favoriteExtendedStations: [ExtendedStation]
    let columns = [
        GridItem(.adaptive(minimum: 150, maximum: 180), spacing: 12),
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(favoriteExtendedStations) { favoriteExtendedStation in
                    Button {
                        handleStationTap(favoriteExtendedStation: favoriteExtendedStation)
                    } label: {
                        LibraryTileView(favoriteStation: favoriteExtendedStation)
                    }
                        .contextMenu() {
                            Button("Unfavorite", systemImage: "star.slash") {
                                Task {
                                    await CachingManager.shared.removeFromFavorites(extendedStationToUnfavorite: favoriteExtendedStation)

                                }
                            }
                        } preview: {
                            Button {
                                handleStationTap(favoriteExtendedStation: favoriteExtendedStation)
                            } label: {
                                LibraryTileView(favoriteStation: favoriteExtendedStation)
                            }
                        }
                }

            }
            

            
        }
        .contentMargins(.bottom, 96, for: .automatic)
        .padding(.horizontal, 8)
    }
}

extension FavoriteView {
    func handleStationTap(favoriteExtendedStation: ExtendedStation)  {

        
        Task {
            await AudioController.shared.playWithSetupExtendedStation(favoriteExtendedStation)
        }
    }
}
