import SwiftUI

struct StationsOfCountryContentView: View {
    @Environment(StationsOfCountryViewController.self) private var stationsModel: StationsOfCountryViewController
    var country: Country
    
    var body: some View {
        @Bindable var stationsModel = stationsModel
        let baseStations = stationsModel.stations
        
        Group {
            if baseStations.isEmpty {
                LoadingView()
            } else {
                UniversalStationsView(baseStations: baseStations, searchText: $stationsModel.searchText)
            }
        }
        .navigationTitle(country.name)
        .task { await handleLoading() }
        .onChange(of: stationsModel.searchText) {
            stationsModel.debounceSearch()
        }
    }
}



extension StationsOfCountryContentView {
    private func handleLoading() async {
        print("Country Browse process")
        StationsOfCountryViewController.selectedCountry = country
        stationsModel.stations = []
        stationsModel.fetchStationsTask.cancel()
        await stationsModel.fetchStationsListForCountry()
    }
}
