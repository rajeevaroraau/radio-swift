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

    func configureAudioSession() {
        os_signpost(.begin, log: pointsOfInterest, name: "AVAudioSessionController.configureAudioSession()")
            do {
                // Configure AVAudioSession
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)
                print("AVAudioSession is ready")
                os_signpost(.end, log: pointsOfInterest, name: "AVAudioSessionController.configureAudioSession()")
            } catch let error {
                Task { await AudioController.shared.pause() }
                os_signpost(.end, log: pointsOfInterest, name: "AVAudioSessionController.configureAudioSession()")
                print("AVAudioSession error: \(error)")
            }
    }
    
    func setActive(_ condition: Bool) {
        do {
            try AVAudioSession.sharedInstance().setActive(condition)
        } catch {
            print("Cannot setActive()")
        }
    }
    
}
