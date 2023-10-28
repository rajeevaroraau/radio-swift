//
//  FullScreenAudioController.swift
//  Radio
//
//  Created by Marcin Wolski on 19/10/2023.
//

import SwiftUI
import SwiftData
struct FullScreenAudioControllerView: View {
    @Environment(AudioModel.self) private var audioModel: AudioModel
    @Environment(PlayingStation.self) private var playingStation: PlayingStation
    @Binding var isShowingSheet: Bool
    @State private var isTouching = false
    @Query var libraryStations: [CachedStation]
    @Environment(\.modelContext) var modelContext
    
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(playingStation.faviconUIImage?.averageColor?.gradient ?? Color.gray.gradient)
            VStack {
                VStack(alignment: .center) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            
                            .foregroundStyle(playingStation.faviconUIImage?.averageColor ?? Color.gray)
                            .padding()
                        faviconCachedImage(image: playingStation.faviconUIImage, height: 100)
                        
                    }
                    
                }
                VStack(alignment: .leading) {
                    HStack {
                        StationTextView(stationName: playingStation.station?.name ?? "Unknown", textAlignment: .leading, textSize: .largeTitle.bold())
                        
                        Spacer()
                        Button("Favourite", systemImage: libraryStations.contains(where: { $0.station == playingStation.station }) ? "star.circle.fill" : "star.circle") {
                            guard let station =  playingStation.station else { return }
                            if let stationToDelete = libraryStations.first(where: { $0.station == playingStation.station }) {
                                modelContext.delete(stationToDelete)
                            } else {
                                let stationTemp = CachedStation(station: station)
                                modelContext.insert(stationTemp)
                                
                                Task {
                                    await stationTemp.fetchStation()
                                }
                            }               
                        }
                        .symbolRenderingMode(.hierarchical)
                        .labelStyle(.iconOnly)
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                        .padding()
                    }
                    .padding()
                    
                }
                VStack(alignment: .center) {
                    Text("LIVE")
                        .foregroundStyle(.white)
                        .opacity(0.5)
                        .bold()
                        .font(.subheadline)
                    HStack {
                        Button {
                            isTouching = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                isTouching = false
                            }
                            audioModel.togglePlayback()
                        } label: {
                            Image(systemName: audioModel.isPlaying ? "pause.fill" : "play.fill")
                                .contentTransition(.symbolEffect(.replace, options: .speed(10.0)))
                                .accessibilityLabel("\(audioModel.isPlaying ? "Pause" : "Resume")")
                                .font(.system(size: 50))
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
                    HStack {
                        AirPlayView()
                        
                            .frame(width:60, height: 60)
                        ShazamButton()
                            .foregroundStyle(.white)
                            .font(.largeTitle)
                            .frame(width: 60, height:60)
                    }
                }
            }
        }
        .colorScheme(.dark)
    }
}
