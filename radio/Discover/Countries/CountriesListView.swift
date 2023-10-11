import SwiftUI

struct CountriesListView: View {
    @Bindable var countriesModel = CountriesController()
    @Environment(StationsController.self) private var stationsModel: StationsController
    @State private var firstTime: Bool = true
    var body: some View {
    
        NavigationView {
            
            Group {
                
                List {
                    
                    ForEach(countriesModel.searchableCountries, id: \.iso_3166_1) { country in
                        NavigationLink  {
                            StationsListView()
                                .onAppear {
                                    stationsModel.stations = []
                                    StationsController.selectedCountry = country
                                }
                        } label: {
                            
                            CountryRow(country: country)
                            
                        }
                    }
                }
                .searchable(text: $countriesModel.searchText, prompt: Text("Search for countries"))
                .disableAutocorrection(true)
            }
            .onFirstAppear {
                Task {
                    await countriesModel.fetchCountries()
                    
                    
                }
                
            }
         
            .navigationTitle("Countries")
     
        }
        
    
    }
    
    
}


public extension View {
    func onFirstAppear(_ action: @escaping () -> ()) -> some View {
        modifier(FirstAppear(action: action))
    }
}

private struct FirstAppear: ViewModifier {
    let action: () -> ()
    
    // Use this to only fire your block one time
    @State private var hasAppeared = false
    
    func body(content: Content) -> some View {
        // And then, track it here
        content.onAppear {
            guard !hasAppeared else { return }
            hasAppeared = true
            action()
        }
    }
}
