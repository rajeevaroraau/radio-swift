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
class ExtendedStation {
    
    
    var stationBase: StationBase
    var faviconData: Data?

    init(stationBase: StationBase, faviconData: Data? = nil) {
        self.stationBase = stationBase
        self.faviconData = faviconData
    }

    var faviconUIImage: UIImage? {
        if let data = faviconData {
            return UIImage(data: data)
        }
        return nil
    }
    
    @MainActor
    func setStationWithFetchingFavicon(_ stationBase: StationBase, faviconCached data: Data?) {
        print("Inside")
        self.stationBase = stationBase
        print("2")

        if let data = data {
            self.faviconData = data
            print("3")

        } else {
            Task { await fetchFavicon() }
            print("4")

        }
        
    }
    
    func fetchFavicon() async {
        await MainActor.run { self.faviconData = nil }
        // CACHE THE COVER ART
        if let faviconURL = URL(string: stationBase.favicon) {
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
