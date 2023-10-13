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

    
    func play() {
        guard playingStation.station != nil else { return }
        
        guard let url = URL(string: playingStation.station!.url) else { return }
        let start = CFAbsoluteTimeGetCurrent()

        do {
            // Configure AVAudioSession
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setCategory(.playback)
            print("here")
            try AVAudioSession.sharedInstance().setActive(true)
    
            // Configure AVPlayer
            playerItem = AVPlayerItem(url: url)
            player.replaceCurrentItem(with: playerItem)
            // RESUME URL STREAM
            player.play()
            setupRemoteCommandCenter()
            updateInfoCenter()
                isPlaying = true
        } catch let error {
            print(error)
          
        }

        print("Took \(CFAbsoluteTimeGetCurrent() - start) seconds")

    }

    
    func updateInfoCenter() {
        
        guard playingStation.station != nil else { return }
        var nowPlayingInfo = nowPlayingInfoCenter.nowPlayingInfo ?? [String: Any]()
        
        UIApplication.shared.beginReceivingRemoteControlEvents()

        // SET NAME
        nowPlayingInfo[MPMediaItemPropertyTitle] = playingStation.station!.name
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = 0
        nowPlayingInfo[MPNowPlayingInfoPropertyIsLiveStream] = true
      //  nowPlayingInfo[MPNowPlayingInfoPropertyAssetURL] = cachedStation.station?.url
      //  nowPlayingInfo[MPMediaItemPropertyMediaType] = MPMediaType.anyAudio
       // nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = 1.0
    //    nowPlayingInfo[MPMediaItemPropertyPersistentID] = UUID().uuidString
        
        nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
        // SET ARTWORK
        // DEFAULT
        if playingStation.faviconData == nil {
            
           
            if let image = UIImage(named: "DefaultFavicon") {
                
                
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
        
    }
    
  
    func resume() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error {
            print(error)
        }
        
        player.play()

    }
    
    func pause() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        isPlaying = false
        do {
            try AVAudioSession.sharedInstance().setActive(false)
        } catch let error {
            print(error)
        }
        player.pause()
        

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
        commandCenter.playCommand.addTarget {event in
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

