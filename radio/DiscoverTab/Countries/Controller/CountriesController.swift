import SwiftUI
import OSLog

@Observable
class CountriesController {
    
    static var shared = CountriesController()
    
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
        Logger.countriesController.notice("Fetching countries...")
        do {
            let data = try await networking.requestCountries()
            os_signpost(.begin, log: pOI, name: "CountriesController.fetchCountries(): Save Data to Memory")
            await MainActor.run { self.countries = data }
            os_signpost(.end, log: pOI, name: "CountriesController.fetchCountries(): Save Data to Memory")
        } catch {
            os_signpost(.end, log: pOI, name: "CountriesController.fetchCountries(): Save Data to Memory")
            Logger.countriesController.error("Fetching error: \(error)")
        }
    }

}
