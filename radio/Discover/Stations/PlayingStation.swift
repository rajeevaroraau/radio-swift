//
//  PlayingStation.swift
//  Radio
//
//  Created by Marcin Wolski on 06/10/2023.
//

import Foundation
import SwiftUI


@Observable
class PlayingStation {
    var faviconData: Data? = nil
    var faviconDataUnwrapped: Data {
      
            return faviconData ?? Data()
    }
    var faviconUIImage: UIImage? {
        if let data = faviconData {
            return UIImage(data: data)
        }
        return nil
    }
    var station: Station? = nil
    
    func fetchFavicon() async -> Data? {
        guard let station = station else { return nil }
        
        
        // CACHE THE COVER ART
        if station.favicon.hasPrefix("https") {
            
            if let faviconURL = URL(string: station.favicon) {
                do {
                    
                    let (data, _) = try await URLSession.shared.data(from: faviconURL)
                    return data

                } catch {
                    print("Cannot cache the station")
                    return nil

                }
            }
        }
        return  nil
        
    }

    init(faviconData: Data? = nil, station: Station? = nil, fetchFavicon: Bool = false) {
        
        
        self.station = station
        if fetchFavicon {
            Task {
                self.faviconData = await self.fetchFavicon()
            }
           
        } else {
            self.faviconData = faviconData
        }
    }
}
