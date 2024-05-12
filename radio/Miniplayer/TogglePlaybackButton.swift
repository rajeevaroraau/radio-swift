//
//  TogglePlaybackButton.swift
//  Radio
//
//  Created by Marcin Wolski on 01/11/2023.
//

import SwiftUI

struct TogglePlaybackButton: View {
    @State private var isTouching = false
    @State var fontSize: CGFloat
    
    var body: some View {
        Button {
            Task { await handlePlayPauseTap() }
        } label: {
            Image(systemName: PlayerState.shared.isPlaying  ? "pause.fill" : "play.fill")
                .contentTransition(.symbolEffect(.replace, options: .speed(10.0)))
                .accessibilityLabel("\(PlayerState.shared.isPlaying ? "Pause" : "Resume")")
                .font(.system(size: fontSize))
                .frame(width: fontSize, height: fontSize)
                .contentShape(
                    Rectangle()
                )
                .tint(.primary)
            // POST-TAP EFFECT
                .overlay(
                    isTouching
                    ? Circle().frame(width: fontSize, height: fontSize).scaleEffect(1.75).foregroundStyle(Color.secondary)
                    : Circle().frame(width: fontSize, height: fontSize).scaleEffect(1.75).foregroundStyle(Color.clear)
                )
                .animation(.easeInOut, value: isTouching)
        }
        .contentShape(Rectangle())
    }
    
    @MainActor
    func handlePlayPauseTap() async {
        animationPlayPauseTap()
        if PlayerState.shared.firstPlay {
            Task {
                guard let currentlyPlayingRichStation = PlayingStation.shared.currentlyPlayingRichStation else { return }
                await AudioController.shared.playRichStation(currentlyPlayingRichStation)
            }
            
        } else {
             AudioController.shared.togglePlayback()
        }
    }
    
    @MainActor
    func animationPlayPauseTap() {
        isTouching = true
        Task {
            try await Task.sleep(nanoseconds: 100_000_000)
            isTouching = false
        }
    }
    
}

