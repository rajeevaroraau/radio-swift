//
//  Container.swift
//  Radio
//
//  Created by Marcin Wolski on 26/11/2023.
//

import Foundation
import SwiftData


class Container {
    static let shared = Container()
    let container: ModelContainer
    
    init() {
        do {
            self.container = try ModelContainer(for: PersistableStation.self)
        } catch {
            fatalError("Cannot load database")
        }
    }
}
