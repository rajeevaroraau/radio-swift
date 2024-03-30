//
//  SearchStationContentView.swift
//  Radio
//
//  Created by Marcin Wolski on 16/03/2024.
//

import SwiftUI

struct SearchStationContentView: View {
    @State private var stationsSearchModel = StationsSearchController()
    var body: some View {
        let baseStations = stationsSearchModel.searchableStations
        let initialStations = stationsSearchModel.initialStations
        let searchText = stationsSearchModel.searchText
            
        Group {
            if initialStations.isEmpty {
                LoadingView()
            } else {
                UniversalStationsView(baseStations: baseStations, filteredStations: stationsSearchModel.filteredSearchedStations, searchText: $stationsSearchModel.searchText, didFetched: $stationsSearchModel.didFetched)
                    .environment(stationsSearchModel)
                
            }
        }
        .navigationTitle("Stations")
        .task { await handleLoading() }
        .onChange(of: stationsSearchModel.searchText) {
            Task {
                await stationsSearchModel.debounceSearch()
            }
            
        }
    }
}



extension SearchStationContentView {
    func handleLoading() async {
        print("Loading started...")
        stationsSearchModel.initialStations = []
        stationsSearchModel.filteredSearchedStations = []
        stationsSearchModel.fetchStationsTask.cancel()
        await stationsSearchModel.fetchInitialStations()
    }
}
