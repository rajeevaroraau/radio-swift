//
//  FavoriteButton.swift
//  Radio
//
//  Created by Marcin Wolski on 29/03/2024.
//

import SwiftUI

struct FavoriteButton: View {
    var favoriteExtendedStation: ExtendedStation
    var body: some View {
        Button {
            stationTap(favoriteExtendedStation)
        } label: {
            FavoriteTileView(favoriteStation: favoriteExtendedStation)
        }
    }
}


extension FavoriteButton {
    func stationTap(_ favoriteExtendedStation: ExtendedStation)  {
        Task {
            await AudioController.shared.playWithSetupExtendedStation(favoriteExtendedStation)
        }
    }
}
