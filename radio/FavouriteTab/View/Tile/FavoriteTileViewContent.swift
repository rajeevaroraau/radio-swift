//
//  FavoriteTileViewContent.swift
//  Radio
//
//  Created by Marcin Wolski on 29/03/2024.
//

import SwiftUI

struct FavoriteTileViewContent: View {
    var favoriteStation: ExtendedStation
    var uiImage: UIImage? {
        favoriteStation.faviconProducts.uiImage
    }
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            VStack(alignment: .leading) {
                ImageFaviconCached(image: uiImage, isPlaceholderLowRes: true, height: 30, isPlayingStationImage: false )
                    
                StationTextView(stationName: favoriteStation.stationBase.name, textAlignment: .leading, textSize: .headline, fontDesign: .rounded)
                    .foregroundStyle(.white)
                    .shadow(color: .black, radius: 10)
            }
            .padding()
        }
    }
}

