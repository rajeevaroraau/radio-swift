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
    
    let image: UIImage?
    let isPlaceholderLowRes: Bool
    let height: CGFloat
    
    var placeholderImage: UIImage {
        if isPlaceholderLowRes {
            return UIImage(named: "DefaultFaviconSmall")!
        } else {
            return UIImage(named: "DefaultFaviconLarge")!
        }
    }
    
    var isPlayingStationImage: Bool
    var manualCornerRadius: Bool = false
    var customCornerRadius: CGFloat? = nil
    var body: some View {
        
        
        Image(uiImage: isPlayingStationImage ? (PlayingStation.shared.faviconUIImage ?? placeholderImage) : image ?? placeholderImage)
            .resizable()
            .accessibilityHidden(true)
            .scaledToFit()
            .frame(width: height, height: height)
            .clipShape(RoundedRectangle(cornerRadius: manualCornerRadius ? (customCornerRadius ?? height/5) : (height/5)))
    }
}


