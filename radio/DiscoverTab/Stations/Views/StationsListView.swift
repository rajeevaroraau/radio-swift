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
                    
                    PlayingStation.shared.extendedStation.setStationWithFetchingFavicon(station, faviconCached: nil)
                    Task {
                        await AudioController.shared.playWithSetup()
                    }
                    
                } label: {
                    StationRowView(faviconCached: nil, station: station)
                }
                .buttonStyle(.plain)
                .swipeActions(allowsFullSwipe: true) {
                    Button {
                        let extendedStationLocal = ExtendedStation(stationBase: station)
                        
                        modelContext.insert(extendedStationLocal)
                        
                        
                        extendedStationLocal.setStationWithFetchingFavicon(station, faviconCached: extendedStationLocal.faviconData)
                        
                    } label: {
                        Label("Favourite", systemImage: "star.circle.fill")
                    }
                }
            }
        }
        .searchable(text: $stationsModel.searchText, placement: .automatic, prompt: Text("Search for stations"))
        .disableAutocorrection(true)
        .contentMargins(.bottom, 96, for: .automatic)
        
        
        
    }
}
