//
//  PlayerState.swift
//  Radio
//
//  Created by Marcin Wolski on 10/12/2023.
//

import Foundation
import Observation

@Observable
@MainActor
class PlayerState {
    static let shared = PlayerState()
    var isPlaying = false
    var firstPlay = true
}
