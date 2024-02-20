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

    var body: some View {
        NavigationStack {
            Group {
                if favoriteExtendedStations.count == 0 {
                    Spacer()
                    ContentUnavailableView("Add Stations", systemImage: "magnifyingglass" , description: Text("You haven't favorited a station yet."))
                    Spacer()
                } else {
                    FavoriteView()
                }
            }
            .navigationTitle("Favourite")
        }
    }
}


