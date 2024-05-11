import SwiftUI
import OSLog

struct StationsOfCountryContentView: View {
    @Environment(StationsOfCountryViewController.self) private var stationsModel: StationsOfCountryViewController
    var country: Country
    
    var body: some View {
        @Bindable var stationsModel = stationsModel
        let baseStations = stationsModel.searchableStations
        let initialStations = stationsModel.stations

        Group {
            if initialStations.isEmpty {
                LoadingView()
            } else {
                UniversalStationsView(baseStations: baseStations,filteredStations: stationsModel.filteredStations , searchText: $stationsModel.searchText, didFetched: $stationsModel.didFetched)
            }
        }
        .onAppear {
            Logger.viewCycle.info("StationsOfCountryContentView appeared")
        }
        .navigationTitle(country.name)
        .task { await handleLoading() }
        .onChange(of: stationsModel.searchText) {
            Task {
                await stationsModel.debounceSearch()
            }
            
        }
    }
}

extension StationsOfCountryContentView {
    private func handleLoading() async {
        Logger.viewCycle.info("Country Button pressed")
        StationsOfCountryViewController.selectedCountry = country
        stationsModel.stations = []
        stationsModel.fetchStationsTask.cancel()
        await stationsModel.fetchStationsListForCountry()
    }
}
