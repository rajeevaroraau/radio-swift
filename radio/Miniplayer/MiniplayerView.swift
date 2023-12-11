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

    
    var body: some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: 15)
                RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(PlayingStation.shared.faviconUIImage?.averageColor?.gradient.opacity(0.3) ?? Color.gray.gradient.opacity(0.3))
                    .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
            }
            .frame(height: 60)
            .foregroundStyle(.ultraThinMaterial)
            
            
            HStack(spacing: 5) {
                
                ImageFaviconCached(image: PlayingStation.shared.faviconUIImage, isPlaceholderLowRes: true, height: 50, isPlayingStationImage: true)
                
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
                
                TogglePlaybackButton(font: .title)
                    .frame(width: 60, height:60)
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
    
    
    }

