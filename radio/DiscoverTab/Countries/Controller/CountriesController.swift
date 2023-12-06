import SwiftUI




@Observable
class CountriesController {
    private let networking = CountryNetworking()
    
    var searchText = ""
    var countries : [Country] = []

    var searchableCountries: [Country] {
        if searchText.isEmpty {
            return countries
        } else {
            return countries.filter { $0.name.localizedStandardContains(searchText) }
        }
    }
    func fetchCountries() async {
        do {
            let data = try await networking.fetchCountries()
            DispatchQueue.main.async {
                self.countries = data
            }
        } catch {
            print(error)
        }
    }
}
