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
    
    var fetchStationsTask = Task{}
    
    
    
    func fetchStationsListForCountry() async {
        do {
            let diagnosticMarker = DiagnosticsMarker(prefix: "[FETCH TIME] \(Country.selectedCountry)")
            let data = try await networking.requestStationListForCountry()
            DispatchQueue.main.async {
                self.stations = data
            }
            diagnosticMarker.printCheckpoint()
        } catch {
            print(error)
        }
    }
}

