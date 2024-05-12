//
//  BigScreenFavicon.swift
//  Radio
//
//  Created by Marcin Wolski on 15/12/2023.
//

import SwiftUI
import SwiftData

struct BigScreenFavicon: View {
    @Query(filter: #Predicate<RichStation> { richStation in richStation.currentlyPlaying } ) var currentlyPlayingRichStation: [RichStation]
    
    var body: some View {
        ImageFaviconCached(image: currentlyPlayingRichStation.first?.faviconProducts.uiImage, isPlaceholderLowRes: false, height: 256, isPlayingStationImage: true, isManualCornerRadius: true, customCornerRadius: 8)
            .shadow(color: .black.opacity(0.2) , radius: 48, y: 48)
            .padding(24)
    }
}

