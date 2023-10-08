//
//  ShazamButton.swift
//  Radio
//
//  Created by Marcin Wolski on 08/10/2023.
//

import SwiftUI

struct ShazamButton: View {
    @Environment(\.openURL) var openURL
    var body: some View {
        if UIApplication.shared.canOpenURL(URL(string: "shazam://shazam")!) {
            Button("Shazam", systemImage: "shazam.logo.fill") {
                openURL(URL(string: "shazam://")!)
                
                
                
            }
            .labelStyle(.iconOnly)
            .contentTransition(.symbolEffect(.replace))
        }
    }
    
}
