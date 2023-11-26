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
    


    
    init() {
        let stationsModel = StationsController()
        
        
        _stationsModel = State(initialValue: stationsModel)
    }

    @State var stationsModel: StationsController
}

extension radioApp {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(Container.shared.container)
        
        .environment(stationsModel)
        
    }
        
}
