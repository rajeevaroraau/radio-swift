import SwiftUI

import Foundation
import SwiftData
import SimpleCodable






@Observable
class StationsViewController {
    static var selectedCountry = Country()
    
    
    private let networking = StationNetworking()
    
    var stations : [Station] = []
    var searchText = ""
    
    var searchableStations: [Station] {
        if searchText.isEmpty {
            return stations.sorted { $0.votes > $1.votes }
        } else {
            return stations.filter { $0.name.localizedStandardContains(searchText) }
            
        }
    }
    
    
    
    // EMPTY TASK ALLOWING FOR TASK CANCELATION
    var fetchStationsTask = Task{ }
    
    
    
    func fetchStationsListForCountry() async {
        do {
            let data = try await networking.requestStationListForCountry()
            self.stations = data
        } catch {
            print("Fetching error: \(error)")
        }
    }
}

