//
//  StationDataNetworking.swift
//  Radio
//
//  Created by Marcin Wolski on 04/11/2023.
//

import SwiftUI
import OSLog
class StationsOfCountryNetworking {
    func requestStationListForCountry() async throws -> [StationBase] {
        os_signpost(.begin, log: pOI, name: "StationNetworking.requestStationListForCountry(): Prepare JSONDecoder")
        // PREPARE CUSTOM JSONDECODER
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        os_signpost(.end, log: pOI, name: "StationNetworking.requestStationListForCountry(): Prepare JSONDecoder")
        let properUrl = URL(string: "\(Connection.baseURL)stations/bycountryexact/\(Country.selectedCountry)")!
        do {
            os_signpost(.begin, log: pOI, name: "StationNetworking.requestStationListForCountry(): Get Data from Request")
            let (data, _) = try await URLSession.shared.data(from: properUrl)
            os_signpost(.end, log: pOI, name: "StationNetworking.requestStationListForCountry(): Get Data from Request")
            os_signpost(.begin, log: pOI, name: "StationNetworking.requestStationListForCountry(): Decode Data")
            let stations = try decoder.decode([StationBase].self, from: data)
            print("Successfully fetched stations from \(properUrl)")
            os_signpost(.end, log: pOI, name: "StationNetworking.requestStationListForCountry(): Decode Data")
            return stations
        } catch {
            print("Request error: \(error)")
            os_signpost(.end, log: pOI, name: "StationNetworking.requestStationListForCountry(): Get Data from Request")
            os_signpost(.end, log: pOI, name: "StationNetworking.requestStationListForCountry(): Decode Data")
            return []
        }
    }
}

