import SwiftUI
import SwiftData
import Foundation
import SimpleCodable

@Codable
@Model
class StationBase: Codable, Equatable, Identifiable {
    let changeuuid: String
    let stationuuid: String
    let name: String
    let url: String
    let homepage: String
    let favicon: String
    let country: String
    let countrycode: String
    let iso_3166_2: String?
    let state: String
    let votes: Int

    
    static func ==(lhs: StationBase, rhs: StationBase) -> Bool {
        return lhs.stationuuid == rhs.stationuuid
    }
    
    
    init(
        changeuuid: String,
        stationuuid: String,
        name: String,
        url: String,
        homepage: String,
        favicon: String,
        country: String,
        countrycode: String,
        iso_3166_2: String?,
        state: String,
        language: String,
        languagecodes: String,
        votes: Int,
        geo_lat: Double?,
        geo_long: Double?
    ) {
        self.changeuuid = changeuuid
        self.stationuuid = stationuuid
        self.name = name
        self.url = url
        self.homepage = homepage
        self.favicon = favicon
        self.country = country
        self.countrycode = countrycode
        self.iso_3166_2 = iso_3166_2
        self.state = state
        self.votes = votes
    }
    
}


