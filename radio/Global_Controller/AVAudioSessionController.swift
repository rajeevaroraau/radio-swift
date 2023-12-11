//
//  AudioSession.swift
//  Radio
//
//  Created by Marcin Wolski on 10/12/2023.
//

import Foundation
import AVFAudio

class AVAudioSessionController {
    static let shared = AVAudioSessionController()
    func configureAudioSession() {
        Task {
            do {
                // Configure AVAudioSession
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)
                print("AVAudioSession is ready")
            } catch let error {
                await MainActor.run {
                    PlayerState.shared.isPlaying = false
                }
                
                print("AVAudioSession error: \(error)")

            }
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
