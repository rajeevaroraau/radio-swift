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
    @Query var favoriteStations: [PersistableStation]
    
    let columns = [
        GridItem(.adaptive(minimum: 180, maximum: 180), spacing: 0),
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(favoriteStations) { favoriteStation in
                    Button { handleStationTap(favoriteStation: favoriteStation) } label: { LibraryTileView(favoriteStation: favoriteStation) }
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
                                    .frame(width: 200, height: 200)
                            }
                        }
                }
            }
            .padding(.horizontal, 5)
        }
    }
}

@MainActor
extension LibraryView {
    func handleStationTap(favoriteStation: PersistableStation)  {
        hapticFeedback()
        PlayingStation.shared.setStation(favoriteStation.station, faviconCached: favoriteStation.faviconData)
        AudioController.shared.playWithSetup()
        
    }
}
