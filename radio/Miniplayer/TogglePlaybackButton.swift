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
            Task {
                await handlePlayPauseTap()
            }

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
            print("PlayingWithSetup...")
            Task {
                guard let currentlyPlayingExtendedStation = PlayingStationManager.shared.currentlyPlayingExtendedStation else { return }
                await AudioController.shared.playWithSetupExtendedStation(currentlyPlayingExtendedStation)
            }
            
        } else {
            print("Toggling the playback")
            await AudioController.shared.togglePlayback()
        }
    }
    
    @MainActor
    func animationPlayPauseTap() {
        isTouching = true
        Task {
            // Delay the task by 1 second:
            try await Task.sleep(nanoseconds: 100_000_000)
            isTouching = false
        }
    }
    
}

