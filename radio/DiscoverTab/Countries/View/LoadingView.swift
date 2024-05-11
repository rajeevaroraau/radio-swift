//
//  LoadingView.swift
//  Radio
//
//  Created by Marcin Wolski on 28/03/2024.
//

import SwiftUI
import OSLog

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
                .padding()
            Text("LOADING...")
                .foregroundStyle(.secondary)
        }
        .onAppear {
            Logger.viewCycle.info("LoadingView appeared")
        }
    }
}
