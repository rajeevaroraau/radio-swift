//
//  AVPlayerController.swift
//  Radio
//
//  Created by Marcin Wolski on 10/12/2023.
//

import Foundation
import AVFoundation
import OSLog

class AVPlayerController {
    static let shared = AVPlayerController()
    
    private var avPlayer = AVPlayer()
    private var playerItem: AVPlayerItem? = nil
    
    func setupAVPlayerItem(url: URL) {
        os_signpost(.begin, log: pointsOfInterest, name: "AVPlayerController.setupAVPlayerItem")
        playerItem = AVPlayerItem(url: url)
        avPlayer.replaceCurrentItem(with: playerItem)
        os_signpost(.end, log: pointsOfInterest, name: "AVPlayerController.setupAVPlayerItem")
        
    }
    
    func play() {
        os_signpost(.begin, log: pointsOfInterest, name: "AVPlayerController.play")
        Task {
            avPlayer.play()
            os_signpost(.end, log: pointsOfInterest, name: "AVPlayerController.play")
        }
    }
    
    func pause() {
        os_signpost(.begin, log: pointsOfInterest, name: "AVPlayerController.pause()")
        Task {
            avPlayer.pause()
            os_signpost(.end, log: pointsOfInterest, name: "AVPlayerController.pause()")
            
        }
    }
    
}
