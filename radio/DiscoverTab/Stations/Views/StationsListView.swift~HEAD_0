import SwiftUI
import AVFoundation
import AVKit
struct StationsListView: View {
    @Environment(StationsController.self) private var stationsModel: StationsController
    @Environment(PlayingStation.self) private var playingStation: PlayingStation
    @Environment(AudioModel.self) private var audioModel: AudioModel
    
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        @Bindable var stationsModel = stationsModel
        // Group {
        
        
        
        if stationsModel.stations == [] {
            ProgressView()
        } else {
            List {
                
                
                ForEach(stationsModel.searchableStations, id: \.stationuuid) { station in
                    Button {
                        
                        if let url = URL(string: station.url) {
                            
                            let playingStationTemp = PlayingStation(station: station, fetchFavicon: true)
                            audioModel.play(playingStation: playingStationTemp, url: url)
                            
                        }
                        
                    } label: {
                        StationRowView(name: station.name, favicon: nil, urlFavicon: station.favicon, isPlaying: playingStation.station == nil ? false : station == playingStation.station!, votes: station.votes)
                        
                    }
                    .buttonStyle(.plain)
                    .swipeActions(allowsFullSwipe: true) {
                        Button {
                            let stationTemp = CachedStation(station: station)
                            modelContext.insert(stationTemp)
                            
                            Task {
                                await stationTemp.fetchStation()
                            }
                            
                            
                            
                            
                        } label: {
                            Label("Favourite", systemImage: "plus")
                        }
                        .tint(.accentColor)
                        
                        
                    }
                }
            }
            .searchable(text: $stationsModel.searchText, prompt: Text("Search for stations"))
            .disableAutocorrection(true)
            
        }
        

        
        //   }
        Text("")
            .navigationTitle("\(StationsController.selectedCountry.name)")
        
            .onChange(of: StationsController.selectedCountry) {
                stationsModel.stations = []
                Task {
                    updateCountry()
                    
                    // await  stationsModel.fetchList()
                }
            }
            .onFirstAppear {
                Task {
                    
                    updateCountry()
                    stationsModel.stations = []
                    await  stationsModel.fetchList()
                }
            }
    }
    func updateCountry() {
        Country.selectedCountry = StationsController.selectedCountry.name.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
    }
}


