//
//  BigScreenBackground.swift
//  Radio
//
//  Created by Marcin Wolski on 15/12/2023.
//

import SwiftUI

struct BigScreenBackground: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(PlayingStation.shared.faviconUIImage?.averageColor ?? Color.gray)
            VStack(spacing:0) {
                Rectangle()
                    .foregroundStyle(PlayingStation.shared.faviconUIImage?.averageColor?.gradient ?? Color.gray.gradient)
                Spacer()
                    .frame(height: UIScreen.main.bounds.height / 3)
            }
        }

        .ignoresSafeArea()
    }
}

