//
//  Container.swift
//  Radio
//
//  Created by Marcin Wolski on 26/11/2023.
//

import Foundation
import SwiftData


class Persistance {
    static let shared = Persistance()
    let container: ModelContainer
    
    init() {
        do {
            container =  try ModelContainer(for:  RichStation.self)
        } catch {
            fatalError("\(error.localizedDescription)")
        }
    }
}
