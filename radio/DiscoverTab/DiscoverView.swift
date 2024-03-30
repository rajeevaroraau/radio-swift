//
//  DiscoverMode.swift
//  Radio
//
//  Created by Marcin Wolski on 28/03/2024.
//

import Foundation
import SwiftUI

struct DiscoverView: View {
    @Environment(DiscoverMode.self) private var discoverMode: DiscoverMode
    @Environment(NetworkMonitor.self) private var networkMonitor: NetworkMonitor
    var body: some View {
        if networkMonitor.isConnected {
            switch discoverMode.mode {
            case .country:
                CountriesListContentView()
            case .station:
                SearchStationContentView()
            }
        }  else {
            NoInternetView()
        }
    }
}

