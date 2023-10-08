//
//  CachedStation.swift
//  Radio
//
//  Created by Marcin Wolski on 06/10/2023.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class CachedStation {
    var faviconData: Data? = nil
    var faviconUIImage: UIImage? {
        if let data = faviconData {
            return UIImage(data: data)
        }
        return nil
    }


    var station: Station
    
    func fetchStation() async {
        
        
        
        // CACHE THE COVER ART
        if station.favicon.hasPrefix("https") {
            
            if let faviconURL = URL(string: station.favicon) {
                do {
                    
                    let (data, _) = try await URLSession.shared.data(from: faviconURL)
                    faviconData = data

                    
                } catch {
                    print("Cannot cache the station")
                    faviconData = nil
                    
                }
            }
        }

        
    }

    init(faviconData: Data? = nil, station: Station) {
        self.faviconData = faviconData
        self.station = station
    }
}
