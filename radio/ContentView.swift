//
//  ContentView.swift
//  radio
//
//  Created by Marcin Wolski on 06/10/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        ZStack(alignment: .bottom) {
            TabView {
                FavoriteContentView()
                    .padding(.bottom, 1)
                    .tabItem { Label("Favorite", systemImage: "star.fill") }
                DiscoverContentView()
                    .tabItem { Label("Discover", systemImage: "magnifyingglass") }
                    
            }
            MiniplayerContentView()
                .shadow(radius: 8)
        }
        .ignoresSafeArea(.keyboard)
    }
}

