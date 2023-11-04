//
//  FullScreenAudioController.swift
//  Radio
//
//  Created by Marcin Wolski on 19/10/2023.
//

import SwiftUI
import SwiftData
struct FullScreenAudioControllerView: View {
    @Environment(AudioModel.self) private var audioModel: AudioModel
    @Environment(PlayingStation.self) private var playingStation: PlayingStation
    @Binding var isShowingSheet: Bool
    @Query var libraryStations: [CachedStation]
    
    
    var body: some View {
        ZStack {
            // BACKGROUND
            Rectangle()
                .foregroundStyle(playingStation.faviconUIImage?.averageColor?.gradient ?? Color.gray.gradient)
            VStack(alignment: .center) {
                
                // COVER
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 10)
                        .containerRelativeFrame(.horizontal)
                        .aspectRatio(1.0, contentMode: .fit)
                        .foregroundStyle(playingStation.faviconUIImage?.averageColor ?? Color.gray)
                    faviconCachedImage(image: playingStation.faviconUIImage, height: 320, manualCornerRadius: true, customCornerRadius: 10)
                    
                }
                .padding(15)

                
                // PRIMARY METADATA
                
                HStack {
                    StationTextView(stationName: playingStation.station?.name ?? "Not Playing", textAlignment: .leading, textSize: .largeTitle.bold())
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





