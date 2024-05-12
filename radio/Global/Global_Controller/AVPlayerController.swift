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
    
    func setupAVPlayerItem(url: URL) async {
        os_signpost(.begin, log: pOI, name: "AVPlayerController.setupAVPlayerItem")
        playerItem = AVPlayerItem(url: url)
        avPlayer.replaceCurrentItem(with: playerItem)
        os_signpost(.end, log: pOI, name: "AVPlayerController.setupAVPlayerItem")
        
    }
    
    func play() async {
        os_signpost(.begin, log: pOI, name: "AVPlayerController.play")
            avPlayer.play()
            os_signpost(.end, log: pOI, name: "AVPlayerController.play")
        
    }
    
    func pause() async {
        os_signpost(.begin, log: pOI, name: "AVPlayerController.pause()")
            avPlayer.pause()
            os_signpost(.end, log: pOI, name: "AVPlayerController.pause()")
    }
    
}
