import SwiftUI
import AVFoundation
import AVKit
struct StationsListView: View {
    @Environment(StationsViewModel.self) private var stationsModel: StationsViewModel
    @Environment(PlayingStation.self) private var playingStation: PlayingStation
    @Environment(AudioModel.self) private var audioModel: AudioModel
    
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        @Bindable var stationsModel = stationsModel
       // Group {
        
     
                
       
            List {
                
                ForEach(stationsModel.searchableStations, id: \.stationuuid) { station in
                    Button {
                        
                        if let url = URL(string: station.url) {
                            let playingStationTemp = PlayingStation()
                            
                            playingStationTemp.station = station
                            

                            audioModel.playingStation = playingStationTemp
                            Task {
                                // FETCHING
                                await playingStationTemp.fetchStation()
                            }
                            audioModel.play(url: url)
                            


                            
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
            
     //   }
        Text("")
        .navigationTitle("\(StationsViewModel.selectedCountry.name)")
         
        .onChange(of: StationsViewModel.selectedCountry) {
            Task {
                updateCountry()
                
                await  stationsModel.fetchList()
            }
        }
            .task {
        
                updateCountry()
            
              await  stationsModel.fetchList()
        }
    }
    func updateCountry() {
        Country.selectedCountry = StationsViewModel.selectedCountry.name.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
    }
}


