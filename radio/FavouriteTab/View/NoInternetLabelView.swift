//
//  NoInternetLabelView().swift
//  Radio
//
//  Created by Marcin Wolski on 29/03/2024.
//

import SwiftUI

struct NoInternetLabelView: View {
    @Environment(NetworkMonitor.self) private var networkMonitor: NetworkMonitor
    
    var body: some View {
        Label("No internet", systemImage:  "wifi.exclamationmark")
            .foregroundStyle(.red)
            .fontDesign(.rounded)
            .fontWeight(.bold)
            .labelStyle(.titleAndIcon)
            
            .animation(.easeInOut, value: networkMonitor.isConnected)
            .transition(.slide)
    }
}


