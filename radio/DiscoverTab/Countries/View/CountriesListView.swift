import SwiftUI

struct CountriesListView: View {
    @Bindable var countriesModel = CountriesController()
    @Environment(StationsViewController.self) private var stationsModel: StationsViewController
    @State private var firstTime: Bool = true
    var body: some View {
        
        NavigationView {
            
            Group {
                if countriesModel.countries == [] {
                    ProgressView()
                } else {
                    List {
                        
                        ForEach(countriesModel.searchableCountries, id: \.iso_3166_1) { country in
                            NavigationLink  {
                                StationsListView()
                                    .onAppear {
                                        hapticFeedback()
                                        stationsModel.stations = []
                                        StationsViewController.selectedCountry = country
                                    }
                            } label: {
                                CountryRow(country: country)
                            }
                        }
                    }
                    .searchable(text: $countriesModel.searchText, prompt: Text("Search for countries"))
                    .disableAutocorrection(true)
                }
            }
            .task {
                await countriesModel.fetchCountries()
            }
            
        }
        
        .navigationTitle("Countries")
    }
    
}


