//
//  LibraryView.swift
//  Radio
//
//  Created by Marcin Wolski on 06/10/2023.
//

import SwiftUI
import SwiftData

struct LibraryContentView: View {
    
    @Query var favoriteStations: [ExtendedStation]

    var body: some View {
        NavigationStack {
            Group {
                if favoriteStations.count == 0 {
                    Spacer()
                    ContentUnavailableView("Add Stations", systemImage: "magnifyingglass" , description: Text("You haven't favorited a station yet."))
                    Spacer()
                } else {
                    LibraryView()
                }
            }
            .navigationTitle("Favourite")
        }
    }
}


