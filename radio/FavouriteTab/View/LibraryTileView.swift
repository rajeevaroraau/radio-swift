//
//  SwiftUIView.swift
//  Radio
//
//  Created by Marcin Wolski on 08/10/2023.
//

import SwiftUI

struct LibraryTileView: View {
    let favoriteStation: PersistableStation
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Group {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.black)
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(favoriteStation.faviconUIImage?.averageColor?.gradient ?? Color.gray.gradient)

                    .opacity(0.8)
            }

            VStack(alignment: .leading) {
                Spacer()
                VStack(alignment: .leading) {
                    ImageFaviconCached(image: favoriteStation.faviconUIImage, isPlaceholderLowRes: true, height: 30, isPlayingStationImage: false )
                    StationTextView(stationName: favoriteStation.station.name, textAlignment: .leading, textSize: .headline)
                        .foregroundStyle(.white)
                }
                .padding()

            }
            // CONTENT PADDING

        }
        .frame(height: 100)

    }
    init(favoriteStation: PersistableStation) {
        self.favoriteStation = favoriteStation
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
