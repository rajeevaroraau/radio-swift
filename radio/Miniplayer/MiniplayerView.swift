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
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(.ultraThinMaterial)
                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                .frame(height: 60)
            
            HStack(spacing: 5) {
                
                faviconCachedImage(image: playingStation.faviconUIImage, height: 50)
                    Text(playingStation.station?.name ?? "Select a station")
                        .font(.headline)
                        .multilineTextAlignment(.leading)
                        .lineSpacing(-3)
                
                Spacer()
                
                ShazamButton()
                    .font(.title)
                    .frame(width: 60, height:60)
                
                Button {
                    handlePlayPauseTap()
                } label: {
                    Image(systemName: audioModel.isPlaying ? "pause.fill" : "play.fill")
                        .contentTransition(.symbolEffect(.replace, options: .speed(10.0)))
                        .accessibilityLabel("\(audioModel.isPlaying ? "Pause" : "Resume")")
                        .font(.title)
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
            .padding(.horizontal, 5)
            .foregroundStyle(.primary)
            .frame(maxWidth: .infinity)
            
        }
        .padding(.horizontal, 10)
        .offset(y: -60)
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

#Preview {
    MiniplayerView()
}
