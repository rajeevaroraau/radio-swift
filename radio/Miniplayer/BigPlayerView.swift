//
//  FullScreenAudioController.swift
//  Radio
//
//  Created by Marcin Wolski on 19/10/2023.
//

import SwiftUI
import SwiftData

struct BigPlayerView: View {
    @Binding var isShowingSheet: Bool    
    
    var body: some View {
        ZStack {
            // BACKGROUND
            Rectangle()
                .foregroundStyle(PlayingStation.shared.faviconUIImage?.averageColor?.gradient ?? Color.gray.gradient)
                .overlay(
                    Color(.black)
                        .opacity(0.15)
                )
            
            VStack(alignment: .center) {
                
                // COVER
                ImageFaviconCached(image: PlayingStation.shared.faviconUIImage, isPlaceholderLowRes: false, height: 320, isPlayingStationImage: true, manualCornerRadius: true, customCornerRadius: 10)
                    .shadow(radius: 10)
                    .padding(15)
                
                
                // STATION NAME AND FAVOURITE BUTTON
                HStack {
                    StationTextView(stationName: PlayingStation.shared.station?.name ?? "Not Playing", textAlignment: .leading, textSize: .largeTitle.bold())
                    Spacer()
                    FavouriteButton()
                }
                .padding(.horizontal, 20)
                
                
                // BUTTONS
                
                HStack {
                    AirPlayButton()
                        .frame(width:60, height: 60)
                    Spacer()
                    TogglePlaybackButton(font: .system(size: 75))
                    Spacer()
                    ShazamButton()
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                        .frame(width: 60, height:60)
                }
                .padding(.horizontal, 20)
                
                
                
                // BUMPER
                Rectangle()
                    .foregroundStyle(.clear)
                    .frame(height:30)
                
            }
        }
        .colorScheme(.dark)
    }
}





