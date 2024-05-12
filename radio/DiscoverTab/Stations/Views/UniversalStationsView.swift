//
//  StationsListView.swift
//  Radio
//
//  Created by Marcin Wolski on 09/12/2023.
//

import SwiftUI
import SwiftData

struct UniversalStationsView: View {
    @Environment(\.modelContext) var modelContext
    var baseStations: [StationBase]
    var filteredStations: [StationBase]
    @Binding var searchText: String
    @Binding var didFetched: Bool
    
    var body: some View {
        Group {
            List {
                ForEach(baseStations, id: \.stationuuid) { baseStation in
                    Button {
                        Task { await AudioController.shared.prepareStationBaseForPlayback(baseStation) }
                    } label: {
                        StationRowView(faviconCached: nil, station: baseStation)
                    }
                    .buttonStyle(.plain)
                    .swipeActions(allowsFullSwipe: true) {
                        Button {
                            Task { 
                                await CachingManager.shared.toggleFavorite(baseStation)
                            }
                        } label: {
                            Label("Favourite", systemImage: "star.circle.fill")
                        }
                    }
                }
                EmptyView()
            }
            .listStyle(.inset)
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: Text("Search for stations"))
            .disableAutocorrection(true)
            .contentMargins(.bottom, 96, for: .automatic)
            
            if searchText.isEmpty == false && filteredStations.isEmpty {
                switch didFetched {
                    case false:
                        VStack {
                            LoadingView()
                            Spacer()
                        }
                    case true:
                        ContentUnavailableView(
                            "Cannot find \(searchText)",
                            systemImage: "magnifyingglass")
                }
            }
        }
    }
}
