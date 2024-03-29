//
//  SearchPicker.swift
//  Radio
//
//  Created by Marcin Wolski on 28/03/2024.
//

import Foundation
import SwiftUI

struct SearchPicker: View {
    @Environment(DiscoverMode.self) private var discoverMode: DiscoverMode
    
    var body: some View {
        @Bindable var discoverMode = discoverMode
        Picker("Item To Search", selection: $discoverMode.mode) {
            ForEach(DiscoverMode.Modes.allCases, id: \.self) { searchMode in
                Text(searchMode.rawValue.localizedString())
            }
        }
        .pickerStyle(.segmented)
    }
}
