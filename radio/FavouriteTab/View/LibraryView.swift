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
                Group {

                if favouriteStations.count == 0 {
                    Spacer()
                    ContentUnavailableView("Add Stations", systemImage: "magnifyingglass" , description: Text("You haven't favourited a station yet."))
                    Spacer()
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 0) {
                            ForEach(favouriteStations) { libraryStation in
                                Button {
                                         handleStationTap(libraryStation: libraryStation)
                                    
                                } label: {
                                    LibraryTileView(libraryStation: libraryStation)
                                    
                                }
                                .contextMenu() {
                                    Button("Unfavourite", systemImage: "heart.slash") {
                                        modelContext.delete(libraryStation)
                                        do {
                                            try  modelContext.save()
                                        } catch {
                                            print("Cannot delete station")
                                        }
                                    }
                                } preview: {
                                    Button {
                                        
                                             handleStationTap(libraryStation: libraryStation)
                                    
                                        
                                    } label: {
                                        LibraryTileView(libraryStation: libraryStation)
                                            .frame(width: 200, height: 200)
                                    }
                                }
                            }
                            
                        }
                        .padding(.horizontal, 5)
                    }
                }
                
                
                
            }
            .navigationTitle("Favourite")
            
        }
    }
    func handleStationTap(libraryStation: PersistableStation)  {
        PlayingStation.shared.setStation(libraryStation.station, faviconCached: libraryStation.faviconData)
        AudioController.shared.play()
    }
}

