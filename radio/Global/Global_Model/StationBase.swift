import SwiftUI
import SwiftData
import Foundation
import SimpleCodable
@Codable
@Model
class StationBase: Codable, Equatable, Identifiable {

    var changeuuid: String
    var stationuuid: String
    var name: String
    var url: String
    var homepage: String
    var favicon: String
    var country: String
    var countrycode: String
    var iso_3166_2: String?
    var state: String
    var votes: Int

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
        votes: Int
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


