//
//  LibraryView.swift
//  Radio
//
//  Created by Marcin Wolski on 06/10/2023.
//

import SwiftUI
import SwiftData

struct LibraryView: View {
    @Environment(\.modelContext) var modelContext
    @Query var favouriteStations: [PersistableStation]
    let columns = [
        GridItem(.adaptive(minimum: 180, maximum: 180), spacing: 0),
        
    ]
    var body: some View {
            NavigationStack {
                ScrollView {

                if favouriteStations.count > 0 {
                    ContentUnavailableView("Add Stations", systemImage: "magnifyingglass" , description: Text("You haven't favourited a station yet."))
                } else {
                    LazyVGrid(columns: columns, spacing: 0) {
                        ForEach(favouriteStations) { libraryStation in
                            Button {
                                Task {
                                    await handleStationTap(libraryStation: libraryStation)
                                }
                            } label: {
                                LibraryTile(libraryStation: libraryStation)
                                
                            }
                            .contextMenu() {
                                Button("Unfavourite", systemImage: "heart.slash") {
                                    modelContext.delete(libraryStation)
                                }
                            } preview: {
                                Button {
                                    Task {
                                        await handleStationTap(libraryStation: libraryStation)
                                    }
                                    
                                } label: {
                                    LibraryTile(libraryStation: libraryStation)
                                        .frame(width: 200, height: 200)
                                }
                            }
                        }
                        
                    }
                    .padding(.horizontal, 5)
                }
                
                
                
            }
            .navigationTitle("Favourite")
            
        }
    }
    func handleStationTap(libraryStation: PersistableStation) async {
        await PlayingStation.shared.setStation(libraryStation.station, faviconCached: libraryStation.faviconData)
        
        AudioController.shared.play()
    }
}

