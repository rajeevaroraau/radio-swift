//
//  FavoriteTileViewBackground.swift
//  Radio
//
//  Created by Marcin Wolski on 29/03/2024.
//

import SwiftUI

struct FavoriteTileViewBackground: View {
    var favoriteStation: ExtendedStation
    
    var color: Color? { favoriteStation.faviconProducts.color }
    var backroundGradient: AnyGradient {
        color?.gradient ?? Color.gray.gradient
    }
    var body: some View {
  
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.black)
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(
                    backroundGradient
                        .shadow(.inner(color: .white.opacity(0.2), radius: 10, x: 5, y: 5))
                )
                .opacity(0.8)
            
            
        }
    }
}

