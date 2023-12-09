//
//  CountryNetworking.swift
//  Radio
//
//  Created by Marcin Wolski on 04/11/2023.
//

import SwiftUI

class CountryNetworking {
    private let url = URL(string: "\(Connection.baseURL)countries?order=stationcount")!

    func requestCountries() async throws -> [Country]{
        do {
            let (data, _) = try await Connection.manager.data(from: url)
            
            let countries = try JSONDecoder().decode([Country].self, from: data)
            print("Successfully fetched countries from \(url)")
            return countries.reversed()
        } catch {
            print(error)
            return []
        }
    }
}
