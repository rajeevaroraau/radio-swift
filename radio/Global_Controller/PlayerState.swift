//
//  PlayerState.swift
//  Radio
//
//  Created by Marcin Wolski on 10/12/2023.
//

import Foundation
import Observation
import OSLog

@Observable
@MainActor
class PlayerState {
    static let shared = PlayerState()
    var isPlaying = false
    var firstPlay = true
    
    func playerStateSetup()  {
        os_signpost(.begin, log: pointsOfInterest, name: "Initially Set PlayerState")
            PlayerState.shared.isPlaying = true
            PlayerState.shared.firstPlay = false
            os_signpost(.end, log: pointsOfInterest, name: "Initially Set PlayerState")
        
    }
}
