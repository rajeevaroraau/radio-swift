import SwiftUI

struct StationsListContentView: View {
    @Environment(StationsViewController.self) private var stationsModel: StationsViewController
    var country: Country
    
    var body: some View {
        @Bindable var stationsModel = stationsModel
        Group {
            if stationsModel.stations == [] {
                VStack {
                    ProgressView()
                        .padding()
                    Text("LOADING...")
                        .foregroundStyle(.secondary)
                }
            } else {
                StationsListView()
            }
        }
        .navigationTitle("\(country.name)")
        
        //        .onChange(of: StationsViewController.selectedCountry) {
        //            StationsViewController.selectedCountry = country
        //
        //            stationsModel.stations = []
        //            stationsModel.fetchStationsTask.cancel()
        //
        //            stationsModel.fetchStationsTask = Task {
        //                await  stationsModel.fetchStationsListForCountry()
        //            }
        //        }
        .task {
            StationsViewController.selectedCountry = country
            stationsModel.stations = []
            
            stationsModel.fetchStationsTask.cancel()
            await  stationsModel.fetchStationsListForCountry()
            
            
        }
        .onChange(of: stationsModel.searchText) {
            stationsModel.debounceSearch()
        }
        
    }
    
    
    
}
