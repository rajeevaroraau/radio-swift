import SwiftUI
import AVFoundation
import AVKit
struct StationsListView: View {
    @Environment(StationsController.self) private var stationsModel: StationsController
    @Environment(AudioModel.self) private var audioModel: AudioModel
    @Environment(PlayingStation.self) private var playingStation: PlayingStation
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
                        
                        playingStation.setStation(station, faviconCached: nil)
                            audioModel.play()

                        
                    } label: {
                        StationRowView(faviconCached: nil, urlFavicon: station.url, station: station)
                        
                        
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


