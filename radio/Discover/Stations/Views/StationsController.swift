import SwiftUI

import Foundation
import AVFoundation
import SwiftData
import SimpleCodable






@Observable

class StationsController {
    


    var stations : [Station] = []
    var searchText = ""
    var searchableStations: [Station] {
        if searchText.isEmpty {
            return stations.sorted { $0.votes > $1.votes }
        } else {
            return stations.filter { $0.name.localizedStandardContains(searchText) }
            
        }
    } 
    
    
    static var selectedCountry = Country()
    
    func fetchList() async {
        await measureTime {
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let properurl = URL(string: "\(Connection.baseURL)stations/bycountryexact/\(Country.selectedCountry)")!
            
            do {
                let (data, _) = try await URLSession.shared.data(from: properurl)
                self.stations = try decoder.decode([Station].self, from: data)
                print("Successfully fetched stations from \(properurl)")
            } catch {
                print(error)
            }
        }
    }
    
}

