//
//  CachedStation.swift
//  Radio
//
//  Created by Marcin Wolski on 06/10/2023.
//

import SwiftUI
import SwiftData
import OSLog
@Model
class ExtendedStation {

    @Observable
    class FaviconProducts {
        var color: Color?
        var uiImage: UIImage?
    }
    
    var stationBase: StationBase
    var currentlyPlaying = false
    var favourite = false
    var faviconData: Data?
    @Transient var faviconProducts = FaviconProducts()
    
    init(stationBase: StationBase, faviconData: Data?)  {
        self.stationBase = stationBase
        self.faviconData = faviconData
    }
    
    func updateFaviconBased() async {
        guard let faviconData = faviconData else { return }
        let uiImage = UIImage(data: faviconData)
        let averageColor = await uiImage?.averageColor()
        await MainActor.run {
            self.faviconProducts.uiImage = uiImage
            self.faviconProducts.color = averageColor
        }
    }
    
    
    func setFavicon(_ data: Data?) async {
        if let data = data {
            self.faviconData = data
            await self.updateFaviconBased()
        } else {
            await fetchFavicon()
        }
        
        
        func fetchFavicon() async {
            // CACHE THE COVER ART
            guard let faviconURL = URL(string: stationBase.favicon) else { return }
            do {
                let (data, _) = try await URLSession.shared.data(from: faviconURL)
                await MainActor.run {
                    self.faviconData = data
                    
                }
                await self.updateFaviconBased()
            } catch {
                Logger.extendedStationNetworking.error("Cannot get data")
            }
        }
    }
}
