//
//  LibraryView.swift
//  Radio
//
//  Created by Marcin Wolski on 06/10/2023.
//

import SwiftUI
import SwiftData

struct LibraryView: View {
    @Environment(AudioModel.self) private var audioModel: AudioModel
    @Environment(\.modelContext) var modelContext
    @Environment(PlayingStation.self) private var playingStation: PlayingStation
    @Query var favouriteStations: [CachedStation]
    let columns = [
        GridItem(.adaptive(minimum: 180, maximum: 180), spacing: 0),
        
    ]
    var body: some View {
      
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(favouriteStations) { libraryStation in
                        Button {
                            handleStationTap(libraryStation: libraryStation)
                        } label: {
                            LibraryTile(libraryStation: libraryStation)
                            
                        }
                        .contextMenu() {
                            Button("Unfavourite", systemImage: "heart.slash") {
                                modelContext.delete(libraryStation)
                            }
                        } preview: {
                            Button {
                                handleStationTap(libraryStation: libraryStation)
                            } label: {
                                LibraryTile(libraryStation: libraryStation)
                                
                            }
                        }
                    }
                    
                }
                .padding(.horizontal, 5)
                
            }
            .navigationTitle("Favourite")
            
        }
    }
    func handleStationTap(libraryStation: CachedStation) {
        playingStation.setStation(libraryStation.station, faviconCached: libraryStation.faviconData)
        audioModel.play()
    }
}

