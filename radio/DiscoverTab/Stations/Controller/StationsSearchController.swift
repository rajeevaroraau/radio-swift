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
    var didFetched = false
    var searchableStations: [StationBase] {
        if (searchText.count < 3 && didFetched == false) {
            return  initialStations
        } else {
            return filteredSearchedStations
        }
    }
    
    
    // EMPTY TASK ALLOWING FOR TASK CANCELATION
    var fetchStationsTask = Task { }
    var searchStationsTask = Task { }
    
    func debounceSearch() async{
        os_signpost(.end, log: pOI, name: "Station Debounce Search")
        os_signpost(.begin, log: pOI, name: "Station Debounce Search")
        await MainActor.run { didFetched = false }
        self.searchStationsTask.cancel()
        guard self.searchText.count > 2 else { return }
        try? await Task.sleep(nanoseconds: 1_000_000_000) // delay
        self.searchStationsTask = Task {
            self.filteredSearchedStations = await fetchSearchedStations()
            didFetched = true
            os_signpost(.end, log: pOI, name: "StationDebounceSearch")
        }
    }
    
    func fetchSearchedStations() async -> [StationBase] {
        do {
            let stations = try await networking.requestSearchedStations(searchText: searchText)
            os_signpost(.begin, log: pOI, name: "StationsViewController.fetchStationsListForCountry(): Save Data to Memory")
            let stationsSorted = stations.sorted { $0.votes > $1.votes }
            
            os_signpost(.end, log: pOI, name: "StationsViewController.fetchStationsListForCountry(): Save Data to Memory")
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
            os_signpost(.begin, log: pOI, name: "Sort initials")
            let stationsSorted = requestedStations.sorted { $0.votes > $1.votes }
            os_signpost(.end, log: pOI, name: "Sort initials")
            initialStations = stationsSorted
            print(initialStations.count)
            
        } catch {
            print("Fetching error: \(error)")
            initialStations = []
            print("No initial stations")
        }
    }
    
    
}

