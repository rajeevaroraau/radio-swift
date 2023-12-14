//
//  SwiftUIView.swift
//  Radio
//
//  Created by Marcin Wolski on 08/10/2023.
//

import SwiftUI

struct LibraryTileView: View {
    let favoriteStation: PersistableStation
    let customPadding: CGFloat
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Group {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.black)
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(favoriteStation.faviconUIImage?.averageColor?.gradient ?? Color.gray.gradient)

                    .opacity(0.8)
            }
            .frame(height: 100)

            VStack(alignment: .leading) {
                ImageFaviconCached(image: favoriteStation.faviconUIImage, isPlaceholderLowRes: true, height: 30, isPlayingStationImage: false )
                StationTextView(stationName: favoriteStation.station.name, textAlignment: .leading, textSize: .headline)
                    .foregroundStyle(.white)
            }
            // CONTENT PADDING
            .padding(12)
        }
        .padding(customPadding)
    }
    init(favoriteStation: PersistableStation, customPadding: CGFloat = 6) {
        self.favoriteStation = favoriteStation
        self.customPadding = customPadding
    }
    
}



struct StationTextView: View {
    let stationName: String
    let textAlignment: TextAlignment
    let textSize: Font
    var body: some View {
        Group {
            Text(stationName)
                .font(textSize)
                .multilineTextAlignment(textAlignment)
                .lineLimit(2)
                .truncationMode(.tail)
                .fontDesign(.rounded)
                
        }
    }
}
