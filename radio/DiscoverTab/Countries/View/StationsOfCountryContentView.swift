import SwiftUI
import OSLog

struct StationsOfCountryContentView: View {
    @Environment(StationsOfCountryViewController.self) private var stationsController: StationsOfCountryViewController
    var country: Country
    
    var body: some View {
        @Bindable var stationsController = stationsController
        let baseStations = stationsController.searchableStations
        let initialStations = stationsController.stations
        
        Group {
            if initialStations.isEmpty {
                LoadingView()
            } else {
                UniversalStationsView(baseStations: baseStations,filteredStations: stationsController.filteredStations , searchText: $stationsController.searchText, didFetched: $stationsController.didFetched)
            }
        }
        .onAppear { Logger.viewCycle.info("StationsOfCountryContentView appeared") }
        .navigationTitle(country.name)
        .task { await handleLoading() }
        .onChange(of: stationsController.searchText) {
            Task {
                await stationsController.debounceSearch()
            }
            
        }
    }
}

extension StationsOfCountryContentView {
    
    private func handleLoading() async {
        Logger.viewCycle.info("Country Button pressed")
        StationsOfCountryViewController.selectedCountry = country
        stationsController.stations = []
        stationsController.fetchStationsTask.cancel()
        await stationsController.fetchStationsListForCountry()
    }
    
}
