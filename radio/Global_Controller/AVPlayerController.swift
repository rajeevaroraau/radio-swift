//
//  AVPlayerController.swift
//  Radio
//
//  Created by Marcin Wolski on 10/12/2023.
//

import Foundation
import AVFoundation

class AVPlayerController {
    static let shared = AVPlayerController()
    
    private var avPlayer = AVPlayer()
    private var playerItem: AVPlayerItem? = nil
    
    func setupAVPlayerItem(url: URL) {
        playerItem = AVPlayerItem(url: url)
        avPlayer.replaceCurrentItem(with: playerItem)
    }
    
    func play() {
        Task {
            avPlayer.play()
        }
        
    }
    
    func pause() {
        Task {
            avPlayer.pause()
        }
        
    }
}
