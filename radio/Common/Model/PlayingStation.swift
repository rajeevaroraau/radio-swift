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
    
    
    private(set)  var station: Station? = nil
    
    
    
    func fetchFavicon() async -> Data? {
        guard let station = self.station else { return nil }
        self.faviconData = nil
        
        // CACHE THE COVER ART
        if station.favicon.hasPrefix("https") {
            
            if let faviconURL = URL(string: station.favicon) {
                do {
                    let (data, _) = try await Connection.manager.data(from: faviconURL)
                    self.faviconData =  data
                    print("Fetched PlayingStation Favicon")
                    
                } catch {
                    print("Cannot cache the station")
                    return nil
                    
                }
            }
        }
        return  nil
        
    }
    func setStation(_ station: Station, faviconCached data: Data?) async {
        self.station = station
        self.faviconData = nil
        
        guard let data = data else {  await self.fetchFavicon(); return }
        
            self.faviconData = data
            print("Set faviconCached as PlayingStation data")
   
    }
}
