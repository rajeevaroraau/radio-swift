//
//  cachedFaviconImage.swift
//  Radio
//
//  Created by Marcin Wolski on 08/10/2023.
//

import Foundation
import SwiftUI

struct faviconCachedImageView: View {
    let image: UIImage?
    let isPlaceholderLowRes: Bool
    
    var placeholderImage: UIImage {
        if isPlaceholderLowRes {
            return UIImage(named: "DefaultFaviconSmall")!
        } else {
            return UIImage(named: "DefaultFaviconLarge")!
        }
    }
    let height: CGFloat
    var manualCornerRadius: Bool = false
    var customCornerRadius: CGFloat? = nil
    var body: some View {


        Image(uiImage: image ?? placeholderImage)
            .resizable()
            .accessibilityHidden(true)
        .scaledToFit()
        .frame(width: height, height: height)
        .clipShape(RoundedRectangle(cornerRadius: manualCornerRadius ? (customCornerRadius ?? height/5) : (height/5)))
        

    }
}

