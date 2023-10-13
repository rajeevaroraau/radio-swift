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
    var body: some View {


        Image(uiImage: image ?? UIImage(named: "DefaultFavicon")!)
            .resizable()
            .accessibilityHidden(true)
        .scaledToFit()
        .frame(width: height, height: height)
        .clipShape(RoundedRectangle(cornerRadius: height/5))
        

    }
}

