//
//  CountryNetworking.swift
//  Radio
//
//  Created by Marcin Wolski on 04/11/2023.
//

import SwiftUI
import OSLog

class CountryNetworking {
    private let url = URL(string: "\(Connection.baseURL)countries?order=stationcount")!
    
    func requestCountries() async throws -> [Country]{
        os_signpost(.begin, log: pointsOfInterest, name: "CountryNetworking.requestCountries()")
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let countries = try JSONDecoder().decode([Country].self, from: data)
            os_signpost(.end, log: pointsOfInterest, name: "CountryNetworking.requestCountries()")
            return countries.reversed()
        } catch {
            os_signpost(.end, log: pointsOfInterest, name: "CountryNetworking.requestCountries()")
            print("Request error: \(error)")
            return []
        }
    }
}
