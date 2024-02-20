import SwiftUI

struct CountriesListContentView: View {
    @State var countriesModel = CountriesController.shared
    
    var body: some View {
        NavigationView {
            Group {
                if countriesModel.countries == [] {
                    VStack {
                        ProgressView()
                            .padding()
                        Text("LOADING...")
                            .foregroundStyle(.secondary)
                    }
                } else {
                    CountriesListView()
                }
            }
            .navigationTitle("Countries")
            .task {
                print("Fetching countries")
                await countriesModel.fetchCountries()
            }
        }
    }
    
}


