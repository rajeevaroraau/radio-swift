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
    @State var stationsModel = StationsViewController()
    

}



extension radioApp {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(SwiftDataContainers.shared.container)
        .environment(stationsModel)
    }
}
