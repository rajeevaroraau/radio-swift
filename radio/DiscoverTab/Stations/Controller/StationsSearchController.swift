import SwiftUI
import Foundation
import SwiftData
import OSLog

@Observable
class StationsSearchController {
    private let networking = StationsSearchNetworking()
    var searchText = ""
    var filteredSearchedStations : [StationBase] = []
    var initialStations: [StationBase] = []
    var searchableStations: [StationBase] {
        if searchText == "" || filteredSearchedStations.isEmpty {
            return initialStations
        } else {
            return filteredSearchedStations
        }
    }

    
    // EMPTY TASK ALLOWING FOR TASK CANCELATION
    var fetchStationsTask = Task { }
    var searchStationsTask = Task { }
    
    func debounceSearch() {
        os_signpost(.end, log: pointsOfInterest, name: "Station Debounce Search")
        os_signpost(.begin, log: pointsOfInterest, name: "Station Debounce Search")
        if self.searchText.count > 2 {
            self.searchStationsTask.cancel()
            Task {
                // Delay the task by 1 second:
                try await Task.sleep(nanoseconds: 1_000_000_000)
                self.searchStationsTask = Task {
                    self.filteredSearchedStations = await fetchSearchedStations()
                }
                print("Search Executed")
                os_signpost(.end, log: pointsOfInterest, name: "Station Debounce Search")
            }
        }
    }
    
    func fetchSearchedStations() async -> [StationBase] {
        do {
            let stations = try await networking.requestSearchedStations(searchText: searchText)
            os_signpost(.begin, log: pointsOfInterest, name: "StationsViewController.fetchStationsListForCountry(): Save Data to Memory")
            let stationsSorted = stations.sorted { $0.votes > $1.votes }
            
            os_signpost(.end, log: pointsOfInterest, name: "StationsViewController.fetchStationsListForCountry(): Save Data to Memory")
            return stationsSorted
        } catch {
            print("Fetching error: \(error)")
            return []
        }
    }
    
    func fetchInitialStations() async  {
        do {
            print("doing work")
            let requestedStations = try await networking.requestInitialStations()
            os_signpost(.begin, log: pointsOfInterest, name: "Sort initials")
            let stationsSorted = requestedStations.sorted { $0.votes > $1.votes }
            os_signpost(.end, log: pointsOfInterest, name: "Sort initials")
            initialStations = stationsSorted
            print(initialStations.count)
            
        } catch {
            print("Fetching error: \(error)")
            initialStations = []
            print("No initial stations")
        }
    }
    
    
}

