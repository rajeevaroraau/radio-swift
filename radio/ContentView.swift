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
                    .padding(.bottom, 60)
                    .tabItem {
                        Label("Favourite", systemImage: "play.square.stack.fill")
                    }
                CountriesListContentView()
                    .padding(.bottom, 60)
                    .tabItem {
                        Label("Discover", systemImage: "magnifyingglass")
                    }
            }
            
            MiniplayerView()
        }
        .ignoresSafeArea(.keyboard)
        
    }
    
    
    
}

