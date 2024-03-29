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
    var filteredStations : [StationBase] = []
    var searchableStations: [StationBase] {
        if searchText == "" {
            return stations
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
    
    func debounceSearch() {
        os_signpost(.end, log: pointsOfInterest, name: "Station Debounce Search")
        os_signpost(.begin, log: pointsOfInterest, name: "Station Debounce Search")
        if self.searchText != "" {
            self.filterStationsTask.cancel()
            Task {
                // Delay the task by 1 second:
                try await Task.sleep(nanoseconds: 200_000_000)
                self.filterStationsTask = Task {
                    self.filteredStations = self.stations.filter { $0.name.localizedStandardContains(self.searchText) }
                }
                print("Search Executed")
                os_signpost(.end, log: pointsOfInterest, name: "Station Debounce Search")
            }
        }
    }
    
    func fetchStationsListForCountry() async {
        do {
            let stations = try await networking.requestStationListForCountry()
            os_signpost(.begin, log: pointsOfInterest, name: "StationsViewController.fetchStationsListForCountry(): Save Data to Memory")
            let stationsSorted = stations.sorted { $0.votes > $1.votes }
            self.stations = stationsSorted
            os_signpost(.end, log: pointsOfInterest, name: "StationsViewController.fetchStationsListForCountry(): Save Data to Memory")
        } catch {
            print("Fetching error: \(error)")
        }
    }
    
}

