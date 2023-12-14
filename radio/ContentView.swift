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
                LibraryContentView()
                    .padding(.bottom, 70)
                    .tabItem {
                        Label("Favourite", systemImage: "play.square.stack.fill")
                    }
                CountriesListContentView()
                    .padding(.bottom, 70)
                    .tabItem {
                        Label("Discover", systemImage: "magnifyingglass")
                    }
            }
            
            MiniplayerView()
                .shadow(radius: 10)
        }
        .ignoresSafeArea(.keyboard)
    }
}

