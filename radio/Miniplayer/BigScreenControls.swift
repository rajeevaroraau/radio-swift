//
//  BigScreenControls.swift
//  Radio
//
//  Created by Marcin Wolski on 15/12/2023.
//

import SwiftUI

struct BigScreenControls: View {
    var body: some View {
        VStack {
            HStack {
                StationTextView(stationName: PlayingStation.shared.station?.name ?? "Not Playing", textAlignment: .leading, textSize: .largeTitle.bold())
                    .shadow(radius: 8, y: 8)
                Spacer()
                FavouriteButton()
                    .shadow(radius: 8, y: 8)
            }
            // STATION NAME AND FAVOURITE BUTTON
            HStack {
                AirPlayButton()
                    .frame(width:64, height: 64)
                Spacer()
                TogglePlaybackButton(fontSize: 48)
                Spacer()
                ShazamButton()
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .frame(width: 64, height:64)
            }
            // BUMPER
            Rectangle()
                .foregroundStyle(.clear)
                .frame(height:32)
        }
        .padding(.horizontal, 24)
    }
    
    
}

#Preview {
    BigScreenControls()
}
