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
            container =  try ModelContainer(for:  ExtendedStation.self)
            print(URL.applicationSupportDirectory.path(percentEncoded: false))
        } catch {
            fatalError("\(error.localizedDescription)")
        }
    }
}


