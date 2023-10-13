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
    @Query var libraryStations: [CachedStation]
    let columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        
    ]
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(libraryStations) { libraryStation in
                        Button {
                            handleStationTap(libraryStation: libraryStation)
                        } label: {
                            LibraryTile(libraryStation: libraryStation)
                            
                        }
                        .contextMenu() {
                            Button("Unlove", systemImage: "heart.slash") {
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
            .navigationTitle("Library")
            
        }
    }
    func handleStationTap(libraryStation: CachedStation) {
        playingStation.setStation(libraryStation.station, faviconCached: libraryStation.faviconData)
        audioModel.play()
    }
}

#Preview {
    LibraryView()
}
