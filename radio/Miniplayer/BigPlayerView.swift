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
                        .opacity(0.2)
                )
            
            VStack(alignment: .center) {
                
                // COVER
                ImageFaviconCached(image: PlayingStation.shared.faviconUIImage, isPlaceholderLowRes: false, height: 260, isPlayingStationImage: true, manualCornerRadius: true, customCornerRadius: 10)
                    .shadow(color: .black.opacity(0.2) , radius: 20, x: 0.0, y: 50.0)
                    .padding(15)
                
                
                // STATION NAME AND FAVOURITE BUTTON
                HStack {
                    StationTextView(stationName: PlayingStation.shared.station?.name ?? "Not Playing", textAlignment: .leading, textSize: .largeTitle.bold())
                        .shadow(radius: 10, y: 10)
                    Spacer()
                    FavouriteButton()
                        .shadow(radius: 10, y: 10)
                }
                .padding(.horizontal, 20)
                
                
                // BUTTONS
                
                HStack {
                    AirPlayButton()
                        .frame(width:60, height: 60)
                    Spacer()
                    TogglePlaybackButton(fontSize: 45)
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
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
}





