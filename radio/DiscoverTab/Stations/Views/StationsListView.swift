import SwiftUI

struct StationsListView: View {
    @Environment(StationsViewController.self) private var stationsModel: StationsViewController
    @Environment(\.modelContext) var modelContext
    var body: some View {
        @Bindable var stationsModel = stationsModel
        Group {
            
            
            
            if stationsModel.stations == [] {
                ProgressView()
            } else {
                List {
                    ForEach(stationsModel.searchableStations, id: \.stationuuid) { station in
                        Button {
                            Task {
                                await PlayingStation.shared.setStationAsync(station)
                            }
                            hapticFeedback()
                            AudioController.shared.play()
                            
                        } label: {
                            StationRowView(faviconCached: nil, station: station)
                            
                            
                            
                        }
                        .buttonStyle(.plain)
                        .swipeActions(allowsFullSwipe: true) {
                            Button {
                                let stationTemp = PersistableStation(station: station)
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
            
            
        }
        .navigationTitle("\(StationsViewController.selectedCountry.name)")
        
        .onChange(of: StationsViewController.selectedCountry) {
            stationsModel.stations = []
            stationsModel.fetchStationsTask.cancel()
            
            stationsModel.fetchStationsTask = Task {
                await  stationsModel.fetchStationsListForCountry()
            }
        }
        .onAppear {
            stationsModel.stations = []
            stationsModel.fetchStationsTask.cancel()
            
            stationsModel.fetchStationsTask = Task {
                await  stationsModel.fetchStationsListForCountry()
            }

        }
    }
    
    
}
