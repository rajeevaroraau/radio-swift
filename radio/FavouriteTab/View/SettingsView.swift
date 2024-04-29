//
//  SettingsView.swift
//  Radio
//
//  Created by Marcin Wolski on 29/04/2024.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("baseURL") var baseURL = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            
            
            Form {
                Section("Radio Directory") {
                    TextField("Web Stations Directory", text: $baseURL)
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItemGroup {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}
#Preview {
    SettingsView()
}
