//
//  CountryNetworking.swift
//  Radio
//
//  Created by Marcin Wolski on 04/11/2023.
//

import SwiftUI
import OSLog

class CountryNetworking {
    init() {
        let baseURL = Connection.baseURL()
        let connectedURL = "\(baseURL)countries?order=stationcount"
        self.url = URL(string: connectedURL)!
    }
    
    let logger = Logger(subsystem: "Radio", category: "CountryNetworking")
    private let url: URL
    
    func requestCountries() async throws -> [Country]{
        os_signpost(.begin, log: pOI, name: "CountryNetworking.requestCountries()")
        do {
            logger.notice("Fetching from \(self.url)...")
            let (data, _) = try await URLSession.shared.data(from: url)
            let countries = try JSONDecoder().decode([Country].self, from: data)
            os_signpost(.end, log: pOI, name: "CountryNetworking.requestCountries()")
            return countries.reversed()
        } catch {
            os_signpost(.end, log: pOI, name: "CountryNetworking.requestCountries()")
            logger.error("Request error: \(error)")
            return []
        }
    }
}
