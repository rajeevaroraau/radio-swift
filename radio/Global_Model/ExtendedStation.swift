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
    var currentlyPlaying = false
    var favourite = false
    var faviconData: Data?
    init(stationBase: StationBase, faviconData: Data? = nil) {
        self.stationBase = stationBase
        self.faviconData = faviconData
    }

    var computedFaviconUIImage: UIImage? {
        if let data = faviconData {
            return UIImage(data: data)
        } else {
            return nil
        }
    }
    
    @MainActor
    func setStationsFavicon(faviconCached data: Data?) {
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
        if let data = data {
            self.faviconData = data
            print("Data set from cache")
        } else {
            Task { await fetchFavicon() }
            print("Fetching favicon")
        }
    }
    
}
