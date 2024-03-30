//
//  MiniplayerControlsView.swift
//  Radio
//
//  Created by Marcin Wolski on 29/03/2024.
//

import SwiftUI

struct MiniplayerControlsView: View {
    var uiImage = PlayingStation.shared.currentlyPlayingExtendedStation?.faviconProducts.uiImage
    var extendedStation: ExtendedStation?
    var body: some View {
        HStack(spacing: 8) {
            ImageFaviconCached(image: uiImage, isPlaceholderLowRes: true, height: 48, isPlayingStationImage: true)
                .shadow(radius: 4)
            Text(extendedStation?.stationBase.name ?? "Nothing Plays")
                .font(.body)
                .bold()
                .multilineTextAlignment(.leading)
                .lineSpacing(-3)
                .lineLimit(2)
                .truncationMode(.tail)
                .contentTransition(.numericText())
            Spacer()
            ShazamButton()
                .font(.title)
                .frame(width: 64, height:64)
            TogglePlaybackButton(fontSize: 28)
                .frame(width: 64, height:64)
                .contentShape(Rectangle())
        }
        .padding(.horizontal, 8)
        .foregroundStyle(.primary)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    MiniplayerControlsView()
}
