import SwiftUI


struct Country: Codable, Equatable {
        var name = ""
        var iso_3166_1 = ""
        var stationcount = -1
    
    static func ==(lhs: Country, rhs: Country) -> Bool {
        lhs.name == rhs.name
    }
    }
extension Country {
    static var selectedCountry = "poland"
}

@Observable class CountriesViewModel {
    var countries : [Country] = []
    var searchText = ""
    var searchableCountries: [Country] {
        if searchText.isEmpty {
            return countries
        } else {
            return countries.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    } 
    func fetchCountries() async {
        let properurl = URL(string: "\(Connection.baseURL)countries?order=stationcount")!
        do {
            print(properurl)
            let (data, _) = try await URLSession.shared.data(from: properurl)
            let countriesAscending = try JSONDecoder().decode([Country].self, from: data)
            countries = countriesAscending.reversed()
        } catch {
            print(error)
        }
    }
}
