//
//  HomepageURLView.swift
//  Radio
//
//  Created by Marcin Wolski on 29/03/2024.
//

import SwiftUI

struct HomepageURLView: View {
    @State private var isShowingAlert = false
    let stationURL = PlayingStation.shared.currentlyPlayingExtendedStation?.stationBase.url
    
    var body: some View {
        if let url = URL(string: stationURL ?? "") {
            Button {
                isShowingAlert = true
            } label: {
                Label("Website", systemImage: "info.circle")
                    .labelStyle(.iconOnly)
                    .foregroundStyle(.white)
                    .padding()
                    .alert("Do you want to open it in the browser?", isPresented: $isShowingAlert) {
                        Button("Open") {
                            UIApplication.shared.open(url, options: [:])
                        }
                        Button("Cancel") { }
                    } message: {
                        Text("Your default browser will open \(url).")
                    }
            }
        } else {
            EmptyView()
        }
    }
}

#Preview {
    HomepageURLView()
}
