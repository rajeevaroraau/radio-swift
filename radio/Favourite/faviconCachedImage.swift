//
//  cachedFaviconImage.swift
//  Radio
//
//  Created by Marcin Wolski on 08/10/2023.
//

import Foundation
import SwiftUI

struct faviconCachedImage: View {
    let image: UIImage?
    let height: CGFloat
    var manualCornerRadius: Bool = false
    var customCornerRadius: CGFloat? = nil
    var body: some View {


        Image(uiImage: image ?? UIImage(named: "DefaultFaviconSmall")!)
            .resizable()
            .accessibilityHidden(true)
        .scaledToFit()
        .frame(width: height, height: height)
        .clipShape(RoundedRectangle(cornerRadius: manualCornerRadius ? (customCornerRadius ?? height/5) : (height/5)))
        

    }
}

