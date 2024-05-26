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
    
    private let url: URL
    
    enum NetworkingError: Error {
        case invalidURL
        case requestFailed(Error)
        case invalidResponse
        case decodingError(Error)
    }
    
    func requestCountries() async throws -> [Country] {
        os_signpost(.begin, log: pOI, name: "CountryNetworking.requestCountries()")
        
        do {
            Logger.countryNetworking.notice("Fetching from \(self.url)...")
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw NetworkingError.invalidResponse
            }
            
            let countries = try JSONDecoder().decode([Country].self, from: data)
            
            os_signpost(.end, log: pOI, name: "CountryNetworking.requestCountries()")
            return countries.reversed()
        } catch {
            os_signpost(.end, log: pOI, name: "CountryNetworking.requestCountries()")
            Logger.countryNetworking.error("Request error: \(error)")
            throw NetworkingError.requestFailed(error)
        }
    }
}
