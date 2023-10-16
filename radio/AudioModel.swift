import SwiftUI
import AVFoundation
import MediaPlayer

@Observable
class AudioModel {
    init(player: AVPlayer = AVPlayer(), playerItem: AVPlayerItem? = nil, isPlaying: Bool = false, playingStation: PlayingStation) {
        self.player = player
        self.playerItem = playerItem
        self.isPlaying = isPlaying
        self.playingStation = playingStation
    }
    
    
    let nowPlayingInfoCenter = MPNowPlayingInfoCenter.default()
    var player = AVPlayer()
    var playerItem: AVPlayerItem? = nil
    var isPlaying = false
    let playingStation: PlayingStation
    let generator = UINotificationFeedbackGenerator()
    
    
    func play() {
        isPlaying = true
        
        guard playingStation.station != nil else { return }
        
        guard let url = URL(string: playingStation.station!.url) else { return }
        let start = CFAbsoluteTimeGetCurrent()
        
        do {
            // Configure AVAudioSession
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            
            
        } catch let error {
            isPlaying = false
            print(error)
            
        }
        // Configure AVPlayer
        playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        // RESUME URL STREAM
        player.play()
        setupRemoteCommandCenter()
        updateInfoCenter()
        
        print("Took \(CFAbsoluteTimeGetCurrent() - start) seconds")
        
    }
    
    
    func updateInfoCenter() {
        
        guard playingStation.station != nil else { return }
        var nowPlayingInfo = nowPlayingInfoCenter.nowPlayingInfo ?? [String: Any]()
        
        
        
        // SET NAME
        nowPlayingInfo[MPMediaItemPropertyTitle] = playingStation.station!.name
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = 0
        nowPlayingInfo[MPNowPlayingInfoPropertyIsLiveStream] = true
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = 1.0
        
        nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
        // SET ARTWORK
        // DEFAULT
        if playingStation.faviconData == nil {
            if let image = UIImage(named: "DefaultFaviconLarge") {
                nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size) { size in
                    print("Set the Default Favicon")
                    return image
                    
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                    if let image = self.playingStation.faviconUIImage {
                        nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size) { size in
                            
                            return image
                        }
                    }
                    self.nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
                }
                nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
                print("Successful second attempt to set remote favicon.")
            }
            
        } else {
            // CUSTOM
            if let image = playingStation.faviconUIImage {
                nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size) { size in
                    print("Successful first attempt to set remote favicon.")
                    return image
                }
            }
        }
        
        // SET THE MPNowPlayingInfoCenter
        nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
        UIApplication.shared.beginReceivingRemoteControlEvents()
        
    }
    
    
    func resume() {
        Task {
            do {
                await generator.notificationOccurred(.success)
                try AVAudioSession.sharedInstance().setActive(true)
                player.play()
            } catch let error {
                print(error)
            }
        }
        
        
    }
    
    func pause() {
        
        isPlaying = false
        
        Task {
            
            do {
                player.pause()
                await generator.notificationOccurred(.success)
                try AVAudioSession.sharedInstance().setActive(false)
            } catch let error {
                print(error)
            }
        }
        
        
        
    }
    @MainActor
    func togglePlayback() {
        if isPlaying {
            isPlaying = false
            pause()
            
        } else {
            
            isPlaying = true
            resume()
        }
    }
    func setupRemoteCommandCenter() {
        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.playCommand.isEnabled = true
        commandCenter.playCommand.addTarget { event in
            self.resume()
            return .success
        }
        commandCenter.pauseCommand.isEnabled = true
        commandCenter.pauseCommand.addTarget { event in
            self.pause()
            return .success
        }
    }
    
}

