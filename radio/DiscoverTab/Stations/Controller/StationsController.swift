import SwiftUI

import Foundation
import SwiftData
import SimpleCodable






@Observable
class StationsController {
    static var selectedCountry = Country()

    
    private let service = StationDataService()
    
    var stations : [Station] = []
    var searchText = ""
    var searchableStations: [Station] {
        if searchText.isEmpty {
            return stations.sorted { $0.votes > $1.votes }
        } else {
            return stations.filter { $0.name.localizedStandardContains(searchText) }
            
        }
    } 
    
    
    
    
    func fetchStationsListForCountry() async {
        do {
            let diagnosticMarker = DiagnosticsMarker(prefix: "[FETCH TIME] \(Country.selectedCountry)")
            let data = try await service.fetchStationsListForCountry()
            DispatchQueue.main.async {
                self.stations = data
            }
            diagnosticMarker.printCheckpoint()
        } catch {
            print(error)
        }
    }
}

