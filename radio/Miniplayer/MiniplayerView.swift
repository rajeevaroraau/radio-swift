//
//  MiniplayerView.swift
//  Radio
//
//  Created by Marcin Wolski on 06/10/2023.
//

import SwiftUI

struct MiniplayerView: View {
    @Environment(AudioModel.self) private var audioModel: AudioModel
    @Environment(PlayingStation.self) private var playingStation: PlayingStation
    @Environment(StationsController.self) private var stationsModel: StationsController

    var body: some View {
        VStack {
            
            HStack(spacing: 0) {
                
                cachedFaviconImage(image: playingStation.faviconUIImage, height: 40)
                if let name = playingStation.station?.name {
                    Text(name)
                        .font(.headline)
                        .padding()
                }
                
                Spacer()
                
                    ShazamButton()


                    .font(.title)

                    
                    .frame(width: 60, height:60)
                
          
            

                
                Button {
                    print("tap!")
                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.success)
                    withAnimation(.easeInOut(duration: 0.02)) {
                        audioModel.togglePlayback()
                    }
                } label: {
                    Image(systemName: audioModel.isPlaying ? "pause.fill" : "play.fill")
                        .contentTransition(.symbolEffect(.replace))
                        .accessibilityLabel("\(audioModel.isPlaying ? "Pause" : "Resume")")
                        .font(.title)
                        .frame(width: 60, height:60)
                        .tint(.primary)



                }
    


                


                .contentShape(Rectangle())
                
                    
                
            }
            .padding(.horizontal, 20)

            .frame(maxWidth: .infinity)
            
           
                    
        }
        .foregroundStyle(.primary)
        .frame(height: 60)
        .background(
            VStack(spacing: 0) {
                Divider()
                BlurView()
                Divider()
            }
            
        )
        .offset(y: -48)
        .ignoresSafeArea(.keyboard)
        

    }
}

#Preview {
    MiniplayerView()
}
