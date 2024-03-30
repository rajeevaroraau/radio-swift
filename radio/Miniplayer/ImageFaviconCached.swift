//
//  cachedFaviconImage.swift
//  Radio
//
//  Created by Marcin Wolski on 08/10/2023.
//

import Foundation
import SwiftUI
import SwiftData

struct ImageFaviconCached: View {
    var image: UIImage?
    var imageUnwrapped: UIImage {
        isPlayingStationImage ? (PlayingStation.shared.currentlyPlayingExtendedStation?.faviconProducts.uiImage ?? placeholderImage) : image ?? placeholderImage
    }
    let isPlaceholderLowRes: Bool
    let height: CGFloat
    var autoCornerRadius: CGFloat {
        return (height / 6)
    }
    var placeholderImage: UIImage {
        if isPlaceholderLowRes {
            return UIImage(named: "DefaultFaviconSmall")!
        } else {
            return UIImage(named: "DefaultFaviconLarge")!
        }
    }
    var isPlayingStationImage: Bool
    var isManualCornerRadius: Bool = false
    var customCornerRadius: CGFloat? = nil
    
    var body: some View {
        Image(uiImage: imageUnwrapped)
            .interpolation(.none)
            .resizable()
            .accessibilityHidden(true)
            .scaledToFit()
            .frame(width: height, height: height)
            .clipShape(.rect(cornerRadius: isManualCornerRadius ? (customCornerRadius ?? autoCornerRadius) : autoCornerRadius))
            .animation(.snappy, value: imageUnwrapped)
            
    }
}


