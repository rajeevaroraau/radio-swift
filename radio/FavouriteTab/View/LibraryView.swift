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
    @Query var favouriteStations: [PersistableStation]
    
    let columns = [
        GridItem(.adaptive(minimum: 180, maximum: 180), spacing: 0),
        
    ]
    var body: some View {
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

extension LibraryView {
    func handleStationTap(libraryStation: PersistableStation)  {
        PlayingStation.shared.setStation(libraryStation.station, faviconCached: libraryStation.faviconData)
        AudioController.shared.play()
    }
    
    
}
