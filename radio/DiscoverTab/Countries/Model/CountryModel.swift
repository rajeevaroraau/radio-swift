//
//  CountryModel.swift
//  Radio
//
//  Created by Marcin Wolski on 11/10/2023.
//

import Foundation

struct Country: Codable, Equatable {
        var name = ""
        var iso_3166_1 = ""
        var stationcount = -1
    
    static func ==(lhs: Country, rhs: Country) -> Bool {
        lhs.name == rhs.name
    }
}
extension Country {
    static var selectedCountry: String {
        return StationsViewController.selectedCountry.name.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
}
