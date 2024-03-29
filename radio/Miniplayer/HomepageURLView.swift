//
//  HomepageURLView.swift
//  Radio
//
//  Created by Marcin Wolski on 29/03/2024.
//

import SwiftUI

struct HomepageURLView: View {
    var body: some View {
        HStack {
            Spacer()
            if let url = URL(string: PlayingStationManager.shared.currentlyPlayingExtendedStation?.stationBase.url ?? "") {
                Link(destination: url) {
                    Label("Website", systemImage: "info.circle")
                        .labelStyle(.iconOnly)
               }
                .foregroundStyle(.white)
            }
        }
        .padding()
    }
}

#Preview {
    HomepageURLView()
}
