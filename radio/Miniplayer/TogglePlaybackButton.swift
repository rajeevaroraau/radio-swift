//
//  TogglePlaybackButton.swift
//  Radio
//
//  Created by Marcin Wolski on 01/11/2023.
//

import SwiftUI

struct TogglePlaybackButton: View {
    @State private var isTouching = false
    let font: Font
    var body: some View {
        Button {
            isTouching = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isTouching = false
            }
            AudioController.shared.togglePlayback()
        } label: {
            Image(systemName: AudioController.shared.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                .contentTransition(.symbolEffect(.replace, options: .speed(10.0)))
                .accessibilityLabel("\(AudioController.shared.isPlaying ? "Pause" : "Resume")")
                .font(font)
                
                .frame(width: 60, height:60)
                .contentShape(
                    Rectangle()
                )
                .tint(.primary)
            // POST-TAP EFFECT
                .background(
                    isTouching
                    ? Circle().fill(Color.secondary).padding(2)
                    : Circle().fill(Color.clear).padding(2)
                    
                )
            
        }
        .contentShape(Rectangle())
    }
}

