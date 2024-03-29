//
//  MiniplayerView.swift
//  Radio
//
//  Created by Marcin Wolski on 06/10/2023.
//

import SwiftUI
import Observation
import SwiftData

struct MiniplayerContentView: View {
    @Environment(StationsOfCountryViewController.self) private var stationsModel: StationsOfCountryViewController
    @State private var isTouching = false
    @State private var isShowingModal = false
    @State private var firstPlay = true
    @Query(filter: #Predicate<ExtendedStation> { extendedStation in extendedStation.currentlyPlaying } ) var currentlyPlayingExtendedStation: [ExtendedStation]
    
    var body: some View {
        ZStack {
            MiniplayerBackgroundView()
            MiniplayerControlsView(extendedStation: currentlyPlayingExtendedStation.first)
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

