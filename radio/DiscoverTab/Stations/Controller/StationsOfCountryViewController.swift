import SwiftUI
import Foundation
import SwiftData
import OSLog

@Observable
class StationsOfCountryViewController {
    static var selectedCountry = Country()
    private let networking = StationsOfCountryNetworking()
    var stations : [StationBase] = []
    var searchText = ""
    var didFetched = false
    var filteredStations : [StationBase] = []
    var searchableStations: [StationBase] {
        if (searchText.count < 3 && didFetched == false) {
            return Array(stations.prefix(100))
        } else {
            return filteredStations
        }
    }
    //    var searchableStations: [Station] = []
    //
    //    func filterStations() {
    //            searchableStations = stations.filter { $0.name.localizedStandardContains(searchText) }
    //
    //
    //    }
    
    // EMPTY TASK ALLOWING FOR TASK CANCELATION
    var fetchStationsTask = Task{ }
    var filterStationsTask = Task{ }
    
    func debounceSearch() async {
        os_signpost(.end, log: pOI, name: "Station Debounce Search")
        os_signpost(.begin, log: pOI, name: "Station Debounce Search")
        await MainActor.run { didFetched = false }
        self.filterStationsTask.cancel()
        guard self.searchText.count > 2 else { return }
        
        // Delay the task by 1 second:
        try? await Task.sleep(nanoseconds: 800_000_000)
        self.filterStationsTask = Task {
            filteredStations = stations.filter { $0.name.localizedStandardContains(searchText) }
            didFetched = true  
            print("Search Executed")
            os_signpost(.end, log: pOI, name: "Station Debounce Search")
        }
        
        
    }
    
    func fetchStationsListForCountry() async {
        do {
            let stations = try await networking.requestStationListForCountry()
            os_signpost(.begin, log: pOI, name: "StationsViewController.fetchStationsListForCountry(): Save Data to Memory")
            let stationsSorted = stations.sorted { $0.votes > $1.votes }
            self.stations = stationsSorted
            os_signpost(.end, log: pOI, name: "StationsViewController.fetchStationsListForCountry(): Save Data to Memory")
        } catch {
            print("Fetching error: \(error)")
        }
    }
    
}

