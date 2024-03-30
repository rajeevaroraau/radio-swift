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
    @Binding var searchText: String
    var body: some View {
        List {
            ForEach(baseStations, id: \.stationuuid) { baseStation in
                Button {
                    Task { await AudioController.shared.prepareStationBaseForPlayback(baseStation) }}
                    label: { StationRowView(faviconCached: nil, station: baseStation)
                }
                .buttonStyle(.plain)
                .swipeActions(allowsFullSwipe: true) {
                    Button {
                        Task { await CachingManager.shared.toggleFavorite(baseStation)}}
                        label: { Label("Favourite", systemImage: "star.circle.fill")
                    }
                }
            }
        }
        .listStyle(.inset)
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: Text("Search for stations"))
        .disableAutocorrection(true)
        .contentMargins(.bottom, 96, for: .automatic)
    }
}
