//
//  SwiftUIView.swift
//  Radio
//
//  Created by Marcin Wolski on 08/10/2023.
//

import SwiftUI

struct LibraryTile: View {
    let libraryStation: CachedStation
    let customPadding: CGFloat
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.black)
                .frame(height: 100)
            RoundedRectangle(cornerRadius: 10)
                
                .foregroundStyle(libraryStation.faviconUIImage?.averageColor?.gradient ?? Color.gray.gradient)
                .frame(height: 100)
                .opacity(0.8)
            
            VStack(alignment: .leading) {
                
                faviconCachedImage(image: libraryStation.faviconUIImage, height: 30)
                StationTextView(stationName: libraryStation.station.name, textAlignment: .leading, textSize: .headline)
                    .foregroundStyle(.white)


            }
            // CONTENT PADDING
            .padding(12)
        
            
        }
        .padding(customPadding)
    }
    init(libraryStation: CachedStation, customPadding: CGFloat = 6) {
        self.libraryStation = libraryStation
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
                
        }
    }
}
