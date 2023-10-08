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
    
    @Environment(AudioModel.self) private var audioModel: AudioModel
    @Environment(PlayingStation.self) private var playingStation: PlayingStation
    
    @Query var libraryStations: [CachedStation]
    var body: some View {
        List {
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
                    StationRowView(name: libraryStation.station.name , favicon: libraryStation.faviconUIImage, urlFavicon: libraryStation.station.favicon, isPlaying: playingStation.station == nil ? false : libraryStation.station == playingStation.station!, votes: libraryStation.station.votes)
                        
                }
                .buttonStyle(.plain)
                .foregroundStyle(.primary)
            }
            .onDelete  { indexSet in
                
                for index in indexSet {
                    modelContext.delete(libraryStations[index])
                }
                
            }
        }
    }
}


