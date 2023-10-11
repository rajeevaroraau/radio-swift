import SwiftUI
import AVFoundation
import MediaPlayer

@Observable
class AudioModel {
    
    let nowPlayingInfoCenter = MPNowPlayingInfoCenter.default()
    var player: AVPlayer = AVPlayer()
    var playerItem: AVPlayerItem? = nil
    var isPlaying = false
    var playingStation: PlayingStation? = nil


    
    func play(playingStation: PlayingStation, url: URL) {
        
        UIApplication.shared.beginReceivingRemoteControlEvents()
        
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
            updateInfoCenter(playingStation: playingStation)
                isPlaying = true
        } catch let error {
            print(error)
          
        }

        
    }

    
    func updateInfoCenter(playingStation: PlayingStation) {
        guard let station = playingStation.station else { return }
        var nowPlayingInfo = nowPlayingInfoCenter.nowPlayingInfo ?? [String: Any]()
        
       
        // SET NAME
        nowPlayingInfo[MPMediaItemPropertyTitle] = station.name
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
                    if let image = playingStation.faviconUIImage {
                        nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size) { size in
                            return image
                        }
                        self.nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
                        print("Successful second attempt to set remote favicon.")
                    }
                    
                }
                
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
        isPlaying = true
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error {
            print(error)
        }
        
        player.play()

    }
    
    func pause() {
        isPlaying = false
        do {
            try AVAudioSession.sharedInstance().setActive(false)
        } catch let error {
            print(error)
        }
        player.pause()

    }
    func togglePlayback() {
        isPlaying ? pause() :  resume()
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

