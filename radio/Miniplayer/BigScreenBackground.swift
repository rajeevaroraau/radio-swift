//
//  BigScreenBackground.swift
//  Radio
//
//  Created by Marcin Wolski on 15/12/2023.
//

import SwiftUI

struct BigScreenBackground: View {
    var body: some View {
        
        ZStack(alignment: .bottomLeading) {
            Rectangle()
                .foregroundStyle(PlayingStation.shared.faviconUIImage?.averageColor ?? Color.gray)
            VStack(spacing:0) {
                Rectangle()
                    .foregroundStyle(PlayingStation.shared.faviconUIImage?.averageColor?.gradient ?? Color.gray.gradient)
                    .frame(height: (UIScreen.main.bounds.height / 3) * 2)
                Spacer()
                
            }
            
            
            Rectangle()
                .foregroundStyle(PlayingStation.shared.faviconUIImage?.averageColor ?? Color.gray)
                .frame(height: UIScreen.main.bounds.height / 3)
                .blur(radius: 5)
                .scaleEffect(1.5)
            
            
            
        }
        
        .ignoresSafeArea()
    }
}

