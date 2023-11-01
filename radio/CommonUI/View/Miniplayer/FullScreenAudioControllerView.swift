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
            Rectangle()
                .foregroundStyle(playingStation.faviconUIImage?.averageColor?.gradient ?? Color.gray.gradient)
            VStack {
                VStack(alignment: .center) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            
                            .foregroundStyle(playingStation.faviconUIImage?.averageColor ?? Color.gray)
                            .padding()
                        faviconCachedImage(image: playingStation.faviconUIImage, height: 100)
                        
                    }
                    
                }
                VStack(alignment: .leading) {
                    HStack {
                        StationTextView(stationName: playingStation.station?.name ?? "Unknown", textAlignment: .leading, textSize: .largeTitle.bold())
                        
                        Spacer()
                        FavouriteButton()
                    }
                    HStack {
                        AirPlayButton()
                            .frame(width:60, height: 60)
                        Spacer()
                        TogglePlaybackButton(font: .system(size: 55))
                        Spacer()
                        ShazamButton()
                            .foregroundStyle(.white)
                            .font(.largeTitle)
                            .frame(width: 60, height:60)
                    }
                    Rectangle()
                        .frame(height:30)
                        .foregroundStyle(.clear)
                }
                .padding()


            }
        }
        .colorScheme(.dark)
    }
}





