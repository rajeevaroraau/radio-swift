//
//  PlayingStation.swift
//  Radio
//
//  Created by Marcin Wolski on 06/10/2023.
//

import Foundation
import SwiftUI
import SwiftData
import Observation

@Model
class PlayingStation {
    static var shared = PlayingStation()
    
    var extendedStation: ExtendedStation
    
    
    init() {
        
        let json = {"""
{
  "changeuuid": "30ab2c13-6038-4895-85a6-1dec17ec8444",
  "stationuuid": "963ccae5-0601-11e8-ae97-52543be04c81",
  "serveruuid": "cf9ec7b9-8d0e-4d30-aec3-e83c7ecb9185",
  "name": "No station selected",
  "url": "https://example.com",
  "url_resolved": "https://example.com",
  "homepage": "http://www.deutschlandfunk.de/",
  "favicon": "http://www.deutschlandfunk.de/static/img/deutschlandfunk/icons/apple-touch-icon-128x128.png",
  "tags": "cultural news,culture,information,kultur,news",
  "country": "Germany",
  "countrycode": "DE",
  "iso_3166_2": null,
  "state": "",
  "language": "german",
  "languagecodes": "de",
  "votes": 34856,
  "lastchangetime": "2023-11-04 17:34:32",
  "lastchangetime_iso8601": "2023-11-04T17:34:32Z",
  "codec": "MP3",
  "bitrate": 128,
  "hls": 0,
  "lastcheckok": 1,
  "lastchecktime": "2023-12-14 22:24:15",
  "lastchecktime_iso8601": "2023-12-14T22:24:15Z",
  "lastcheckoktime": "2023-12-14 22:24:15",
  "lastcheckoktime_iso8601": "2023-12-14T22:24:15Z",
  "lastlocalchecktime": "2023-12-14 22:24:15",
  "lastlocalchecktime_iso8601": "2023-12-14T22:24:15Z",
  "clicktimestamp": "2023-12-15 19:24:35",
  "clicktimestamp_iso8601": "2023-12-15T19:24:35Z",
  "clickcount": 7539,
  "clicktrend": -4,
  "ssl_error": 0,
  "geo_lat": null,
  "geo_long": null,
  "has_extended_info": false
}
"""
        }()
        let data = json.data(using: .utf8)
        guard let data = data  else { fatalError("Bad data") }
        let faviconData = imageToData()
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            let stationBase = try decoder.decode(StationBase.self, from: data)
            let initialExtendedStation = ExtendedStation(stationBase: stationBase, faviconData: faviconData)
            self.extendedStation = initialExtendedStation
        } catch {
            fatalError("Cannot decode JSON from PlayingStation Init")
        }
        
        
    }
}

func imageToData() ->  Data {
    if let image = UIImage(named: "DefaultFaviconLarge"),
       let imageData = image.pngData() {
        // Now you have the data representation of the image in PNG format
        return imageData
    } else {
        print("Unable to convert UIImage to Data.")
    }
    return Data()
}
