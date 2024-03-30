//
//  FavoriteButton.swift
//  Radio
//
//  Created by Marcin Wolski on 29/03/2024.
//

import SwiftUI

struct FavoriteButton: View {
    @State private var isPushed = false
    var favoriteExtendedStation: ExtendedStation
    var body: some View {
        Button {
            stationTap(favoriteExtendedStation)
        } label: {
            FavoriteTileView(favoriteStation: favoriteExtendedStation)
        }
        .scaleEffect(isPushed ? 0.8 : 1.0)
        .animation(.easeOut, value: isPushed)
    }
}


extension FavoriteButton {
    func stationTap(_ favoriteExtendedStation: ExtendedStation)  {
        isPushed = true
        Task {
            try await Task.sleep(nanoseconds: 100_000_000)
            isPushed = false
        }
        Task {
            await AudioController.shared.playWithSetupExtendedStation(favoriteExtendedStation)
        }
    }
}
