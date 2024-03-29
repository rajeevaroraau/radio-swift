//
//  LibraryView.swift
//  Radio
//
//  Created by Marcin Wolski on 06/10/2023.
//

import SwiftUI
import SwiftData

struct FavoriteContentView: View {
    @Query(filter: #Predicate<ExtendedStation> { extendedStation in extendedStation.favourite } ) var favoriteExtendedStations: [ExtendedStation]
    @Environment(NetworkMonitor.self) private var networkMonitor: NetworkMonitor
    
    var body: some View {
        NavigationStack {
            Group {
                if favoriteExtendedStations.isEmpty {
                    NoStationsFavorited()
                } else {
                    ZStack(alignment: .top) {
                        PlayingBackground()
                        FavoriteView()
                    }
                }
            }
            .navigationTitle("Favourite Stations")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    if !networkMonitor.isConnected { NoInternetLabelView()
                    }
                }
            }
        }
    }
}
