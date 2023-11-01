//
//  MiniplayerView.swift
//  Radio
//
//  Created by Marcin Wolski on 06/10/2023.
//

import SwiftUI
import Observation

struct MiniplayerView: View {
    @Environment(AudioModel.self) private var audioModel: AudioModel
    @Environment(StationsController.self) private var stationsModel: StationsController
    @Environment(PlayingStation.self) private var playingStation: PlayingStation
    @State private var isTouching = false
    @State private var isShowingSheet = false
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)

                .foregroundStyle(.ultraThinMaterial)
                .frame(height: 60)
            RoundedRectangle(cornerRadius: 15)

                .foregroundStyle(playingStation.faviconUIImage?.averageColor?.gradient.opacity(0.3) ?? Color.gray.gradient.opacity(0.3))
                .foregroundStyle(.ultraThinMaterial)
                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                .frame(height: 60)
            
            HStack(spacing: 5) {
                
                faviconCachedImage(image: playingStation.faviconUIImage, height: 50)
                
                Text(playingStation.station?.name ?? "Select a station")
                    .font(.body)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .lineSpacing(-3)
                    .lineLimit(2)
                    .truncationMode(.tail)
                Spacer()
                
                ShazamButton()
                    .font(.title)
                    .frame(width: 60, height:60)
                
                Button {
                    handlePlayPauseTap()
                } label: {
                    TogglePlaybackButton(font: .title)
                        .frame(width: 60, height:60)

                    
                }
                .contentShape(Rectangle())
            }
            .padding(.horizontal, 5)
            .foregroundStyle(.primary)
            .frame(maxWidth: .infinity)
            
        }
        .padding(.horizontal, 10)
        .offset(y: -60)
        .onTapGesture {
            isShowingSheet = true
        }
        .gesture(DragGesture(minimumDistance: 10.0, coordinateSpace: .local)
            .onEnded { value in
                
                switch(value.translation.height) {
                case ...(-40):  
                    print("up swipe : \(value.translation) [\(value.translation.height)]")
                    isShowingSheet = true
                default:  print("no clue : \(value.translation) [\(value.translation.height)]")
                }
            }
        )
        .sheet(isPresented: $isShowingSheet) {
            
            FullScreenAudioControllerView(isShowingSheet: $isShowingSheet)
        }
    }
    
    
    @MainActor
    func handlePlayPauseTap() {
        isTouching = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            isTouching = false
        }
        audioModel.togglePlayback()
    }
}
