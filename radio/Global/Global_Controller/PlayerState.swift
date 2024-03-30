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
    let logger = Logger(subsystem: "Radio", category: "PlayerState")

    static let shared = PlayerState()
    var isPlaying = false
    var firstPlay = true
    

    
    func playerStateSetup(_ extendedStation: ExtendedStation)  {
        os_signpost(.begin, log: pOI, name: "Initially Set PlayerState")
            PlayerState.shared.isPlaying = true
            PlayerState.shared.firstPlay = false
            os_signpost(.end, log: pOI, name: "Initially Set PlayerState")
        logger.info("PlayerState for \(extendedStation.stationBase.name) has been set")
    }
    
    
}
