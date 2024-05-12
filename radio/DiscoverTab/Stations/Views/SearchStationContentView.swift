//
//  SearchStationContentView.swift
//  Radio
//
//  Created by Marcin Wolski on 16/03/2024.
//

import SwiftUI
import OSLog

struct SearchStationContentView: View {
    @State private var stationsSearchModel = StationsSearchController()
    
    var body: some View {
        let baseStations = stationsSearchModel.searchableStations
        let initialStations = stationsSearchModel.initialStations
        
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
        .onAppear {
            Logger.viewCycle.info("SearchStationContentView appeared")
        }
        .onChange(of: stationsSearchModel.searchText) {
            Task {
                await stationsSearchModel.debounceSearch()
            }
            
        }
    }
}

extension SearchStationContentView {
    
    func handleLoading() async {
        Logger.searchingStation.info("Loading started...")
        stationsSearchModel.initialStations = []
        stationsSearchModel.filteredSearchedStations = []
        stationsSearchModel.fetchStationsTask.cancel()
        await stationsSearchModel.fetchInitialStations()
    }
    
}
