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
        let searchText = stationsSearchModel.searchText
        Group {
            if !baseStations.isEmpty {
                UniversalStationsView(baseStations: baseStations, searchText: $stationsSearchModel.searchText)
            } else {
                if searchText.isEmpty {
                    LoadingView()
                } else {
                    Text("Cannot find \(searchText)")
                }
            }
        }
        .navigationTitle("Stations")
        .task { await handleLoading() }
        .onChange(of: stationsSearchModel.searchText) {
            stationsSearchModel.debounceSearch()
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
