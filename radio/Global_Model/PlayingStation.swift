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
    
    // ACTUAL MODEL
    private(set) var station: Station? = nil
    
    //RAW FAVICON DATA
    var faviconData: Data? = nil
    var faviconUIImage: UIImage? { if let faviconData = faviconData { UIImage(data: faviconData) } else { nil } }
    
    init(faviconData: Data? = nil, station: Station? = nil) {
        self.faviconData = faviconData
        self.station = station
    }
}


extension PlayingStation {
    func setStationWithFetchingFavicon(_ station: Station, faviconCached data: Data?) {
        self.station = station
        if let data = data {
            self.faviconData = data
        } else {
            Task { await fetchFavicon() }
        }
        
    }
    
    func fetchFavicon() async {
        guard let station = self.station else {
            print("No station in fetchFavicon()");
            return
        }
        await MainActor.run { self.faviconData = nil }
        // CACHE THE COVER ART
        if let faviconURL = URL(string: station.favicon) {
            do {
                let (data, _) = try await URLSession.shared.data(from: faviconURL)
                await MainActor.run { self.faviconData =  data }
            } catch {
                await MainActor.run { self.faviconData = nil }
            }
        } else {
            print("No favicon link")
        }
    }
    
    
    

}
