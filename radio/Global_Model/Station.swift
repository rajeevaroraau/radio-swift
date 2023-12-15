import SwiftUI
import SwiftData
import Foundation
import SimpleCodable

@Codable
@Model

class Station: Codable, Equatable, Identifiable {
    let changeuuid: String
    let stationuuid: String
    let name: String
    let url: String
    let url_resolved: String
    let homepage: String
    let favicon: String
    let country: String
    let countrycode: String
    let iso_3166_2: String?
    let state: String
    let language: String
    let languagecodes: String
    let votes: Int
    let lastchangetime_iso8601: Date
    let codec: String
    let bitrate: Int
    let hls: Int
    let lastcheckok: Int
    let lastchecktime: String
    let lastchecktime_iso8601: Date
    let lastcheckoktime_iso8601: Date?
    let lastlocalchecktime_iso8601: Date?
    let clicktimestamp: String
    let clickcount: Int
    let clicktrend: Int
    let ssl_error: Int
    let geo_lat: Double?
    let geo_long: Double?
    let has_extended_info: Bool
    
    static func ==(lhs: Station, rhs: Station) -> Bool {
        return lhs.url == rhs.url
    }
    
    
    
    init(changeuuid: String, stationuuid: String, name: String, url: String, url_resolved: String, homepage: String, favicon: String, tags: String, country: String, countrycode: String, iso_3166_2: String?, state: String, language: String, languagecodes: String, votes: Int, lastchangetime: String, lastchangetime_iso8601: Date, codec: String, bitrate: Int, hls: Int, lastcheckok: Int, lastchecktime: String, lastchecktime_iso8601: Date, lastcheckoktime: String, lastcheckoktime_iso8601: Date?, lastlocalchecktime: String, lastlocalchecktime_iso8601: Date?, clicktimestamp: String, clickcount: Int, clicktrend: Int, ssl_error: Int, geo_lat: Double?, geo_long: Double?, has_extended_info: Bool) {
        self.changeuuid = changeuuid
        self.stationuuid = stationuuid
        self.name = name
        self.url = url
        self.url_resolved = url_resolved
        self.homepage = homepage
        self.favicon = favicon
        self.country = country
        self.countrycode = countrycode
        self.iso_3166_2 = iso_3166_2
        self.state = state
        self.language = language
        self.languagecodes = languagecodes
        self.votes = votes
        self.lastchangetime_iso8601 = lastchangetime_iso8601
        self.codec = codec
        self.bitrate = bitrate
        self.hls = hls
        self.lastcheckok = lastcheckok
        self.lastchecktime = lastchecktime
        self.lastchecktime_iso8601 = lastchecktime_iso8601
        self.lastcheckoktime_iso8601 = lastcheckoktime_iso8601
        self.lastlocalchecktime_iso8601 = lastlocalchecktime_iso8601
        self.clicktimestamp = clicktimestamp
        self.clickcount = clickcount
        self.clicktrend = clicktrend
        self.ssl_error = ssl_error
        self.geo_lat = geo_lat
        self.geo_long = geo_long
        self.has_extended_info = has_extended_info
    }

}


