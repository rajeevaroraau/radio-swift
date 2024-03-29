//
//  SwiftUIView.swift
//  Radio
//
//  Created by Marcin Wolski on 08/10/2023.
//

import SwiftUI

struct FavoriteTileView: View {
    var favoriteStation: ExtendedStation
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            FavoriteTileViewBackground(favoriteStation: favoriteStation)
            FavoriteTileViewContent(favoriteStation: favoriteStation)
            // CONTENT PADDING
        }
        .frame(height: 100)
        .drawingGroup()
    }

}

