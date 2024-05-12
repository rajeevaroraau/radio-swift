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
        Button("Shazam", systemImage: "shazam.logo.fill") { openURL(URL(string: "shazam://")!) }
        .labelStyle(.iconOnly)
        .contentTransition(.symbolEffect(.replace))
        .disabled(!UIApplication.shared.canOpenURL(URL(string: "shazam://shazam")!))
    }
}
