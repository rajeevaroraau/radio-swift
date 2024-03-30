//
//  SourceInfoView.swift
//  Radio
//
//  Created by Marcin Wolski on 30/03/2024.
//

import SwiftUI

struct SourceInfoView: View {
    @State private var isPresented = false
    var body: some View {
        Button {
            isPresented = true
        } label: {
            Label(
                title: { Text("Information") },
                icon: { Image(systemName: "info.circle") }
            )
            .foregroundStyle(.secondary)
            .labelStyle(.iconOnly)
            .font(.caption2)
        }
        .alert("Data provided by radio-browser.info", isPresented: $isPresented) {
            Button("OK", role: .cancel) { isPresented = false }
        } message: {
            Text("The app provides you with thousands of radio stations thanks to the curiosity of radio-browser.info")
        }
    }
}


