//
//  DynamicImageFaviconView.swift
//  Radio
//
//  Created by Marcin Wolski on 14/12/2023.
//

import SwiftUI

struct DynamicImageFaviconView: View {
    let faviconCached: UIImage?
    var urlFavicon: String
    var body: some View {
        if let faviconCached = faviconCached {
            ImageFaviconCached(image: faviconCached, isPlaceholderLowRes: true, height: 50, isPlayingStationImage: false)
        } else {
            // CHECK IF AN FAVICONURL EXISTS
            if let url = URL(string: urlFavicon) {
                AsyncImage(url: url) { phase in
                    // SHOW LOADED IMAGE
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 48, height: 48)
                            .clipShape(RoundedRectangle(cornerRadius: 48/6))
                        // IF STILL LOADING SHOW PLACEHOLDER
                    } else {
                        DefaultFaviconView()
                    }
                }
            } else {
                DefaultFaviconView()
            }
        }
    }
}

#Preview {
    DynamicImageFaviconView(faviconCached: nil, urlFavicon: "https://wp.inews.co.uk/wp-content/uploads/2021/10/PRI_205675309-760x557.jpg")
}
