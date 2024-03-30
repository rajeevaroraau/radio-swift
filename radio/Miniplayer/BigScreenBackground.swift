//
//  BigScreenBackground.swift
//  Radio
//
//  Created by Marcin Wolski on 15/12/2023.
//

import SwiftUI

struct BigScreenBackground: View {
    var faviconColor: Color {
        PlayingStation.shared.currentlyPlayingExtendedStation?.faviconProducts.color ?? Color.gray
    }
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Rectangle()
                .foregroundStyle(faviconColor.gradient)
                
//            Rectangle()
//                .foregroundStyle(faviconColor)
//                .frame(height: UIScreen.main.bounds.height / 3)
//                .blur(radius: 50)
//                .scaleEffect(1.5)
        }
        .ignoresSafeArea()
    }
}

