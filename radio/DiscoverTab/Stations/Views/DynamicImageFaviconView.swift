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
                            .frame(width: 50, height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 50/6))
                            .onAppear {
                                print("Rich favicon loaded in StationRowView")
                            }
                        // IF STILL LOADING SHOW PLACEHOLDER
                    } else {
                        ProgressView()
                            .frame(width: 50, height: 50)
                            .onAppear {
                                print("Temporary screen loaded in StationRowView")
                            }
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
