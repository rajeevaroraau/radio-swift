//
//  FavoriteView.swift
//  Radio
//
//  Created by Marcin Wolski on 09/12/2023.
//

import SwiftUI
import SwiftData

struct FavoriteView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(NetworkMonitor.self) private var networkMonitor: NetworkMonitor
    @Query(filter: #Predicate<RichStation> { richStation in richStation.favourite } ) var favoriteRichStations: [RichStation]
    let columns = [ GridItem(.adaptive(minimum: 150, maximum: 180), spacing: 12) ]
    
    var body: some View {
        let favoriteRichStations = favoriteRichStations
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(favoriteRichStations) { favoriteRichStation in
                    FavoriteButton(favoriteRichStation: favoriteRichStation)
                        .disabled(!networkMonitor.isConnected)
                        .contextMenu() {
                            UnfavoriteContextButton(richStation: favoriteRichStation)
                        } preview: {
                            FavoriteTileView(favoriteStation: favoriteRichStation)
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

