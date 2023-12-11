//
//  Container.swift
//  Radio
//
//  Created by Marcin Wolski on 26/11/2023.
//

import Foundation
import SwiftData

@MainActor
class SwiftDataContainers {
    static let shared = SwiftDataContainers()
    let container: ModelContainer
    
    
    init() {
        do {

            container = try ModelContainer(for: PlayingStation.self, PersistableStation.self)
           
        } catch {
            fatalError("Failed to configure SwiftData container.")
        }
    }
}


