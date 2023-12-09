//
//  StationsListView.swift
//  Radio
//
//  Created by Marcin Wolski on 09/12/2023.
//

import SwiftUI
import SwiftData

struct StationsListView: View {
    @Environment(StationsViewController.self) private var stationsModel: StationsViewController
    @Environment(\.modelContext) var modelContext
    var body: some View {
        
        @Bindable var stationsModel = stationsModel
        
        List {
            ForEach(stationsModel.searchableStations, id: \.stationuuid) { station in
                Button {
                    Task {
                        await PlayingStation.shared.setStationAsync(station)
                    }
                    hapticFeedback()
                    AudioController.shared.play()
                    
                } label: {
                    StationRowView(faviconCached: nil, station: station)
                    
                    
                    
                }
                .buttonStyle(.plain)
                .swipeActions(allowsFullSwipe: true) {
                    Button {
                        let stationTemp = PersistableStation(station: station)
                        
                        modelContext.insert(stationTemp)
                        hapticFeedback()

                        Task {
                            await stationTemp.fetchStation()
                        }
                        
                        
                        
                        
                    } label: {
                        Label("Favourite", systemImage: "star.circle.fill")
                    }
                }
            }
        }
        .disableAutocorrection(true)
        .searchable(text: $stationsModel.searchText, placement: .automatic, prompt: Text("Search for stations"))
        
    }
}
