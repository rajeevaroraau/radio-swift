//
//  BigScreenBackground.swift
//  Radio
//
//  Created by Marcin Wolski on 15/12/2023.
//

import SwiftUI

struct BigScreenBackground: View {
    var body: some View {
        VStack(spacing:0) {
            Rectangle()
                .foregroundStyle(PlayingStation.shared.faviconUIImage?.averageColor?.gradient ?? Color.gray.gradient)
            Rectangle()
                .foregroundStyle(PlayingStation.shared.faviconUIImage?.averageColor ?? Color.gray)
                .frame(height: UIScreen.main.bounds.height / 3)
        }
        .ignoresSafeArea()
    }
}

