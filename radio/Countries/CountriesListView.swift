import SwiftUI

struct CountriesListView: View {
    @Bindable var countriesModel = CountriesViewModel()
    @State private var firstTime: Bool = true
    var body: some View {
    
        NavigationView {
            
            Group {
                
                List {
                    
                    ForEach(countriesModel.searchableCountries, id: \.iso_3166_1) { country in
                        NavigationLink  {
                            StationsListView()
                                .onAppear {
                                    StationsViewModel.selectedCountry = country
                                }
                        } label: {
                            
                            CountryRow(country: country)
                            
                        }
                    }
                }
                .searchable(text: $countriesModel.searchText, prompt: Text("Search for countries"))
                .disableAutocorrection(true)
            }
            
            .onAppear {
                if firstTime {
                    firstTime = false
                    Task {
                        await countriesModel.fetchCountries()
                        
                        
                    }
                }
                
            }
         
            .navigationTitle("Countries")
     
        }
        
    
    }
    
    
}
