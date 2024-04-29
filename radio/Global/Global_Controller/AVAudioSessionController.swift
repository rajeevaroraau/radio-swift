//
//  AudioSession.swift
//  Radio
//
//  Created by Marcin Wolski on 10/12/2023.
//

import Foundation
import AVFAudio
import OSLog

class AVAudioSessionController {
    static let shared = AVAudioSessionController()
    let logger = Logger(subsystem: "Radio", category: "AudioController")
    func configureAudioSession() async {
        os_signpost(.begin, log: pOI, name: "AVAudioSessionController.configureAudioSession()")
            do {
                // Configure AVAudioSession
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)
                logger.notice("AVAudioSession is ready")
                os_signpost(.end, log: pOI, name: "AVAudioSessionController.configureAudioSession()")
            } catch let error {
                await AudioController.shared.pause()
                os_signpost(.end, log: pOI, name: "AVAudioSessionController.configureAudioSession()")
                logger.error("AVAudioSession error: \(error)")
            }
    }
    
    func setActive(_ condition: Bool) async {
        do {
            try AVAudioSession.sharedInstance().setActive(condition)
        } catch {
            logger.error("Cannot setActive()")
        }
    }
    
}
