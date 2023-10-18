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
    @Environment(PlayingStation.self) private var playingStation: PlayingStation
    @Environment(AudioModel.self) private var audioModel: AudioModel
    
    @Query var libraryStations: [CachedStation]
    var body: some View {
        List {
            ForEach(libraryStations) { libraryStation in
                Button {             
                        playingStation.setStation(libraryStation.station, faviconCached: libraryStation.faviconData)
                        audioModel.play()
                } label: {
                    StationRowView(faviconCached: nil, station: libraryStation.station)
                    
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


