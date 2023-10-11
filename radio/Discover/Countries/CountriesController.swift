import SwiftUI




@Observable 
class CountriesController {
    var countries : [Country] = []
    var searchText = ""
    var searchableCountries: [Country] {
        if searchText.isEmpty {
            return countries
        } else {
            return countries.filter { $0.name.localizedStandardContains(searchText) }
        }
    } 
    func fetchCountries() async {
        let properurl = URL(string: "\(Connection.baseURL)countries?order=stationcount")!
        do {
            print(properurl)
            let (data, _) = try await URLSession.shared.data(from: properurl)
            let countriesAscending = try JSONDecoder().decode([Country].self, from: data)
            countries = countriesAscending.reversed()
            print("Successfully fetched countries from \(properurl)")
        } catch {
            print(error)
        }
    }
}
