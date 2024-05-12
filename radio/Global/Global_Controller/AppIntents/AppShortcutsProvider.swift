//
//  AppShortcutsProvider.swift
//  Radio
//
//  Created by Marcin Wolski on 26/11/2023.
//

import Foundation
import AppIntents
import SwiftData

struct AddTodayShortcuts: AppShortcutsProvider {
    
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: TogglePlayback(),
            phrases: ["Toggle playback in \(.applicationName)",],
            shortTitle: "Toggle Playback",
            systemImageName: "playpause.fill"
        )
        
        AppShortcut(
            intent: FavouriteStation(),
            phrases: ["I like the \(.applicationName) station", "I love the \(.applicationName) station"],
            shortTitle: "Favourite station",
            systemImageName: "star.fill"
        )
        
    }
    
}


