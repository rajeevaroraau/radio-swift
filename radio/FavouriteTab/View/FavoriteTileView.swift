//
//  SwiftUIView.swift
//  Radio
//
//  Created by Marcin Wolski on 08/10/2023.
//

import SwiftUI

struct FavoriteTileView: View {
    let favoriteStation: RichStation
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            FavoriteTileViewBackground(favoriteStation: favoriteStation)
            FavoriteTileViewContent(favoriteStation: favoriteStation)
        }
        .task { await favoriteStation.updateFaviconBased() }
        .frame(height: 100)
        .drawingGroup()
    }
}


