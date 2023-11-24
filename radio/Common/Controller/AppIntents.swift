//
//  AppIntents.swift
//  Radio
//
//  Created by Marcin Wolski on 10/11/2023.
//

import Foundation
import AppIntents
import SwiftData


struct TogglePlayback: AppIntent {
    static var title: LocalizedStringResource = "Toggle Playback"

    @MainActor
    func perform() async throws -> some IntentResult {
        AudioController.shared.togglePlayback()
        return .result()
    }
  
}

struct FavouriteStation: AppIntent {
    static var title: LocalizedStringResource = "Favourite"
    @MainActor
    func perform() async throws -> some IntentResult {
        guard let modelContainer = try? ModelContainer(for: PersistableStation.self) else {
            print("No container")
            return .result()
        }
        guard let station = PlayingStation.shared.station else {
            print("No")
            return .result()
        }
        modelContainer.mainContext.insert(station)
        do {
            try modelContainer.mainContext.save()
            print("Favourite Done!")
            return .result()
        } catch {
            print("Bad")
        }
        return .result()
       
    }
  
}







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
        phrases: ["Favourite the station in \(.applicationName)",],
        shortTitle: "Favourite station",
        systemImageName: "star.fill"
      )
  }
}


