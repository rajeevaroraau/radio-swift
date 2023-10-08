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
    @State private var gridView = true
    let columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),

    ]
    var body: some View {
        NavigationView {
            Group {
                
                
                if gridView {
                    ScrollView {
                        
                        
                        LazyVGrid(columns: columns, spacing: 0) {
                            
                            ForEach(libraryStations) { libraryStation in
                                
                                Button {
                                    if let url = URL(string: libraryStation.station.url) {
                                        
                                        
                                        playingStation.station = libraryStation.station
                                        let playingStationTemp = PlayingStation()
                                        playingStationTemp.station = libraryStation.station
                                        Task {
                                            await playingStationTemp.fetchStation()
                                        }
                                        audioModel.playingStation = playingStationTemp
                                        audioModel.play(url: url)
                                        playingStation.station = libraryStation.station
                                        Task {
                                            // FETCHING
                                            
                                            await playingStation.fetchStation()
                                        }

                                        
                                    }
                                } label: {
                                    LibraryTile(libraryStation: libraryStation)
                                    .padding(6)
                                }

                            }
                            
                            
                        }
                        .padding(.horizontal, 5)
                    }
                } else {
                    LibraryListView()
                }
            }
            .toolbar {
                Button("\(gridView ? "List style" : "Grid style")", systemImage: gridView ? "list.bullet" : "rectangle.grid.2x2.fill") {
                    withAnimation {
                        gridView.toggle()
                    }
                    
                }
            }
            .navigationTitle("Library")
        }
    }
}

#Preview {
    LibraryView()
}
