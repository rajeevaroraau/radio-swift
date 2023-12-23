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
                .foregroundStyle(PlayingStation.shared.extendedStation.faviconUIImage?.averageColor?.gradient ?? Color.gray.gradient)
            Rectangle()
                .foregroundStyle(PlayingStation.shared.extendedStation.faviconUIImage?.averageColor ?? Color.gray)
                .frame(height: UIScreen.main.bounds.height / 3)
        }
        .ignoresSafeArea()
    }
}

