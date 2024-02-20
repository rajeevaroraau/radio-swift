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
            ForEach(stationsModel.searchableStations, id: \.stationuuid) { baseStation in
                Button {
                    //PlayingStation.shared.extendedStation?.setStationWithFetchingFavicon(faviconCached: nil)
                    Task {
                        await AudioController.shared.playWithSetupStationBase(baseStation)
                    }
                    
                } label: {
                    StationRowView(faviconCached: nil, station: baseStation)
                }
                .buttonStyle(.plain)
                .swipeActions(allowsFullSwipe: true) {
                    Button {
                        Task {
                            await CachingManager.shared.addToFavorites(stationBaseToInsert: baseStation)
                        }
                        // extendedStationLocal.setStationsFavicon(faviconCached: extendedStationLocal.faviconData)
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
