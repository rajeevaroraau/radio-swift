//
//  BigScreenFavicon.swift
//  Radio
//
//  Created by Marcin Wolski on 15/12/2023.
//

import SwiftUI

struct BigScreenFavicon: View {
    var body: some View {
        ImageFaviconCached(image: PlayingStation.shared.faviconUIImage, isPlaceholderLowRes: false, height: 256, isPlayingStationImage: true, isManualCornerRadius: true, customCornerRadius: 8)
            .shadow(color: .secondary.opacity(0.2) , radius: 64, y: 48)
            .shadow(color: .black.opacity(0.2) , radius: 20, y: 48)
            .padding(.horizontal, 24)

    }
}

