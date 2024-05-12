//
//  UnfavoriteContextButton.swift
//  Radio
//
//  Created by Marcin Wolski on 29/03/2024.
//

import SwiftUI

struct UnfavoriteContextButton: View {
    var richStation: RichStation
    
    var body: some View {
        Button("Unfavorite", systemImage: "star.slash") {
            Task { await CachingManager.shared.removeFromFavorites(richStation) }
        }
    }
}


