//
//  MiniplayerView.swift
//  Radio
//
//  Created by Marcin Wolski on 06/10/2023.
//

import SwiftUI
import Observation

struct MiniplayerView: View {
    @Environment(StationsController.self) private var stationsModel: StationsController
    @State private var isTouching = false
    @State private var isShowingModal = false
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)

                .foregroundStyle(.ultraThinMaterial)
                .frame(height: 60)
            RoundedRectangle(cornerRadius: 15)

                .foregroundStyle(PlayingStation.shared.faviconUIImage?.averageColor?.gradient.opacity(0.3) ?? Color.gray.gradient.opacity(0.3))
                .foregroundStyle(.ultraThinMaterial)
                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                .frame(height: 60)
            
            HStack(spacing: 5) {
                
                faviconCachedImageView(image: PlayingStation.shared.faviconUIImage, isPlaceholderLowRes: true, height: 50)
                
                Text(PlayingStation.shared.station?.name ?? "Select a station")
                    .font(.body)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .lineSpacing(-3)
                    .lineLimit(2)
                    .truncationMode(.tail)
                    .contentTransition(.numericText())
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
            isShowingModal = true
        }
        .gesture(DragGesture(minimumDistance: 10.0, coordinateSpace: .local)
            .onEnded { value in
                
                switch(value.translation.height) {
                case ...(-40):  
                    print("up swipe : \(value.translation) [\(value.translation.height)]")
                    isShowingModal = true
                default:  print("no clue : \(value.translation) [\(value.translation.height)]")
                }
            }
        )
        .fullScreenCover(isPresented: $isShowingModal) {
            
            BigPlayerView(isShowingSheet: $isShowingModal)
                .gesture(DragGesture(minimumDistance: 10.0, coordinateSpace: .local)
                    .onEnded { value in
                        
                        switch(value.translation.height) {
                        case (20)...:
                            print("up swipe : \(value.translation) [\(value.translation.height)]")
                            isShowingModal = false
                        default:  print("no clue : \(value.translation) [\(value.translation.height)]")
                        }
                    }
                )
        }
    }
    
    
    @MainActor
    func handlePlayPauseTap() {
        isTouching = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            isTouching = false
        }
        AudioController.shared.togglePlayback()
    }
}
