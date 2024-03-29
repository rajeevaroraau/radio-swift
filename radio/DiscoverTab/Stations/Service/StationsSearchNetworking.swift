//
//  StationsSearchNetworking.swift
//  Radio
//
//  Created by Marcin Wolski on 28/03/2024.
//

import Foundation
import OSLog

class StationsSearchNetworking {
    func requestSearchedStations(searchText: String) async throws -> [StationBase]{
        
        let url = URL(string: "\(Connection.baseURL)stations/search?name=\(searchText)&limit=100")!
        
        os_signpost(.begin, log: pointsOfInterest, name: "CountryNetworking.requestCountries()")
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let stations = try JSONDecoder().decode([StationBase].self, from: data)
            os_signpost(.end, log: pointsOfInterest, name: "CountryNetworking.requestCountries()")
            return stations
        } catch {
            os_signpost(.end, log: pointsOfInterest, name: "CountryNetworking.requestCountries()")
            print("Request error: \(error)")
            return []
        }
    }
    
    func requestInitialStations() async throws -> [StationBase] {
        
        let url = URL(string: "\(Connection.baseURL)stations/topvote/15")!
        print(url)
        os_signpost(.begin, log: pointsOfInterest, name: "CountryNetworking.requestCountries()")
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let stations = try JSONDecoder().decode([StationBase].self, from: data)
            print(stations.count)
            os_signpost(.end, log: pointsOfInterest, name: "CountryNetworking.requestCountries()")
            return stations
        } catch {
            os_signpost(.end, log: pointsOfInterest, name: "CountryNetworking.requestCountries()")
            print("Request error: \(error)")
            return []
        }
    }
    
}
