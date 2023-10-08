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
                LibraryView()
                    .padding(.bottom, 50)
                    .tabItem {
                        Label("Library", systemImage: "play.square.stack.fill")
                    }
                CountriesListView()
                    .padding(.bottom, 50)
                    .tabItem {
                        Label("Discover", systemImage: "magnifyingglass")
                    }
            }
            
            
            MiniplayerView()


            
        }
        .ignoresSafeArea(.keyboard)
            
        
          
    
    }
    
    
    
}


#Preview {
    ContentView()
}
