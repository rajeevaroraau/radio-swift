//
//  FavoriteBackground.swift
//  Radio
//
//  Created by Marcin Wolski on 29/03/2024.
//

import SwiftUI

struct PlayingBackground: View {
    var playingColor = PlayingStation.shared.currentlyPlayingRichStation?.faviconProducts.color ?? Color.clear
    
    var body: some View {
        VStack {
            Spacer()
            LinearGradient(colors: [Color.clear, playingColor], startPoint: .top, endPoint: .bottom)
                .opacity(0.6)
                .ignoresSafeArea()
                .drawingGroup()
                .animation(.smooth, value: playingColor)
        }
    }
}
