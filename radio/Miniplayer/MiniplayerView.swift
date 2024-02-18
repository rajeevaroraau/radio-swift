//
//  MiniplayerView.swift
//  Radio
//
//  Created by Marcin Wolski on 06/10/2023.
//

import SwiftUI
import Observation
import SwiftData

struct MiniplayerView: View {
    @Environment(StationsViewController.self) private var stationsModel: StationsViewController
    @State private var isTouching = false
    @State private var isShowingModal = false
    @State private var firstPlay = true
    @Query(filter: #Predicate<ExtendedStation> { extendedStation in extendedStation.currentlyPlaying } ) var currentlyPlayingExtendedStation: [ExtendedStation]

    
    var body: some View {
        ZStack {
            // MARK: - BACKGROUND
            Group {
                RoundedRectangle(cornerRadius: 16)
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(PlayingStationManager.shared.currentlyPlayingExtendedStation?.computedFaviconUIImage?.averageColor?.gradient.opacity(0.3) ?? Color.gray.gradient.opacity(0.3))
            }
            .frame(height: 64)
            .foregroundStyle(.ultraThinMaterial)
            
            // MARK: - BODY
            HStack(spacing: 8) {
                
                ImageFaviconCached(image: PlayingStationManager.shared.currentlyPlayingExtendedStation?.computedFaviconUIImage, isPlaceholderLowRes: true, height: 48, isPlayingStationImage: true)
                
                Text(currentlyPlayingExtendedStation.first?.stationBase.name ?? "Nothing Plays")
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
                    .frame(width: 64, height:64)
                
                TogglePlaybackButton(fontSize: 28)
                    .frame(width: 64, height:64)
                .contentShape(Rectangle())
            }
            .padding(.horizontal, 8)
            .foregroundStyle(.primary)
            .frame(maxWidth: .infinity)
            
        }
        .foregroundStyle(.white)
        .padding(8)
        .offset(y: -48)
        .onTapGesture {
            isShowingModal = true
        }
        // MARK: - GESTURE
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
        // MARK: - BIGPLAYERVIEW
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
    
    
    }

