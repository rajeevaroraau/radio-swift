//
//  MiniplayerBackgroundView.swift
//  Radio
//
//  Created by Marcin Wolski on 29/03/2024.
//

import SwiftUI

struct MiniplayerBackgroundView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(PlayingStation.shared.currentlyPlayingExtendedStation?.faviconProducts.color?.gradient.opacity(0.3) ?? Color.gray.gradient.opacity(0.3))
        }
        .frame(height: 64)
        .foregroundStyle(.ultraThinMaterial)
    }
}

