//
//  LibraryView.swift
//  Radio
//
//  Created by Marcin Wolski on 09/12/2023.
//

import SwiftUI
import SwiftData

struct FavoriteView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(NetworkMonitor.self) private var networkMonitor: NetworkMonitor
    
    @Query(filter: #Predicate<ExtendedStation> { extendedStation in extendedStation.favourite } ) var favoriteExtendedStations: [ExtendedStation]
    let columns = [ GridItem(.adaptive(minimum: 150, maximum: 180), spacing: 12) ]
    
    var body: some View {
        let favoriteExtendedStations = favoriteExtendedStations
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(favoriteExtendedStations) { favoriteExtendedStation in
                    FavoriteButton(favoriteExtendedStation: favoriteExtendedStation)
                        .disabled(!networkMonitor.isConnected)
                        .contextMenu() {
                            UnfavoriteContextButton(extendedStation: favoriteExtendedStation)
                        } preview: {
                            FavoriteTileView(favoriteStation: favoriteExtendedStation)
                        }
                }
            }
            
            .scaleEffect(networkMonitor.isConnected ? 1.0 : 0.95)
            .opacity(networkMonitor.isConnected ? 1.0 : 0.6)
        }
        
        
        .animation(.spring, value: networkMonitor.isConnected)
        .contentMargins(.bottom, 96, for: .automatic)
        .padding(.horizontal, 8)
        .shadow(radius: 10)
    }
}

