//
//  MiniplayerView.swift
//  Radio
//
//  Created by Marcin Wolski on 06/10/2023.
//

import SwiftUI
import Observation
import SwiftData
import OSLog

struct MiniplayerContentView: View {
    @Environment(StationsOfCountryViewController.self) private var stationsController: StationsOfCountryViewController
    @State private var isTouching = false
    @State private var isShowingModal = false
    @State private var firstPlay = true
    @State private var hapticCounter = 0
    @Query(filter: #Predicate<RichStation> { richStation in richStation.currentlyPlaying } ) var currentlyPlayingRichStation: [RichStation]
    
    var body: some View {
        ZStack {
            MiniplayerBackgroundView()
            MiniplayerControlsView(richStation: currentlyPlayingRichStation.first)
        }
        .foregroundStyle(.white)
        .padding(8)
        .offset(y: -48)
        .sensoryFeedback(.start, trigger: hapticCounter)
        .onTapGesture {
            hapticCounter += 1
            isShowingModal = true
        }
        .gesture(
            DragGesture(minimumDistance: 10.0, coordinateSpace: .local)
            .onChanged { value in
                switch(value.translation.height) {
                    case ...(-40):
                        print("Up swipe : \(value.translation) [\(value.translation.height)]")
                        isShowingModal = true
                    default:
                        print("Unrecognized gesture : \(value.translation) [\(value.translation.height)]")
                }
            }
        )
        
        .fullScreenCover(isPresented: $isShowingModal) {
            BigPlayerView(isShowingSheet: $isShowingModal)
                .gesture(
                    DragGesture(minimumDistance: 10.0, coordinateSpace: .local)
                    .onChanged { value in
                        switch(value.translation.height) {
                            case (30)...:
                                print("Recognized swipe up : \(value.translation) [\(value.translation.height)]")
                                isShowingModal = false
                            default:
                                print("Unrecognized gesture : \(value.translation) [\(value.translation.height)]")
                        }
                    }
                )
        }
    }
}

