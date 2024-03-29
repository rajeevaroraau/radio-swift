//
//  FullScreenAudioController.swift
//  Radio
//
//  Created by Marcin Wolski on 19/10/2023.
//

import SwiftUI
import SwiftData

struct BigPlayerView: View {
    @Binding var isShowingSheet: Bool
    
    var body: some View {
        ViewThatFits {
            ZStack {
                BigScreenBackground()
                HStack {
                    HomepageURLView()
                    BigScreenFavicon()
                    BigScreenControls()
                }
            }
            ZStack {
                BigScreenBackground()
                VStack(alignment: .center) {
                    HomepageURLView()
                    BigScreenFavicon()
                    BigScreenControls()
                }
            }
        }
        .colorScheme(.dark)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
}

#Preview {
    EmptyView()
}


