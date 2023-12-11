//
//  StationDataNetworking.swift
//  Radio
//
//  Created by Marcin Wolski on 04/11/2023.
//

import SwiftUI

class StationNetworking {
    func requestStationListForCountry() async throws -> [Station] {
        
        
        // PREPARE CUSTOM JSONDECODER
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        let properUrl = URL(string: "\(Connection.baseURL)stations/bycountryexact/\(Country.selectedCountry)")!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: properUrl)
            
            return try await MainActor.run {
                let stations = try decoder.decode([Station].self, from: data)
                print("Successfully fetched stations from \(properUrl)")
                
                return stations
            }
        } catch {
            print("Request error: \(error)")
            return []
        }
    }
}

