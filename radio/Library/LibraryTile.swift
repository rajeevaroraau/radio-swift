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
                .foregroundStyle(.blue.gradient)
                .frame(height: 100)
            
            VStack(alignment: .leading) {
                
                cachedFaviconImage(image: libraryStation.faviconUIImage, height: 30)
                
                Text(libraryStation.station.name)
                    .font(.headline)
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

