//
//  radioApp.swift
//  radio
//
//  Created by Marcin Wolski on 06/10/2023.
//

import SwiftUI
import SwiftData

@main
struct radioApp: App {
    @State var stationsModel = StationsOfCountryViewController()
    @State private var networkMonitor = NetworkMonitor()

}

extension radioApp {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(Persistance.shared.container)
                .environment(stationsModel)
                .environment(networkMonitor)
                .onAppear {
                    let defaultURL = Connection.defaultURL
                    UserDefaults.standard.register(defaults: ["baseURL": defaultURL])
                }
        }
      
    }
}
