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
        self.nowPlayingInfo = nowPlayingInfoCenter.nowPlayingInfo ?? [String: Any]()
    }
    
    private let nowPlayingInfoCenter = MPNowPlayingInfoCenter.default()
    private var player = AVPlayer()
    private var playerItem: AVPlayerItem? = nil
    var isPlaying = false
    let playingStation: PlayingStation
   private  let generator = UINotificationFeedbackGenerator()
    
    private var nowPlayingInfo: [String: Any]
    
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
    private func updateInfoCenter()  {
        
        guard playingStation.station != nil else { return }
        
        
        
        
        // SET NAME
        nowPlayingInfo[MPMediaItemPropertyTitle] = playingStation.station!.name
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = 0
        nowPlayingInfo[MPNowPlayingInfoPropertyIsLiveStream] = true
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = 1.0
        
        nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
        // SET ARTWORK
        // DEFAULT
        Task {
            await setRemoteFavicon()
        }
        
        
        // SET THE MPNowPlayingInfoCenter
        nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
        DispatchQueue.main.async {
            UIApplication.shared.beginReceivingRemoteControlEvents()
        }
        
        
    }
    private func setRemoteFavicon() async {
        // FIRST ATTEMPT
        if let image = playingStation.faviconUIImage {
            nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size) { size in
                print("Successful first attempt to set remote favicon.")
                return image
            }
            
            // SECOND ATTEMPT
        } else {
            guard let image = UIImage(named: "DefaultFaviconLarge") else  { return }
        
            // DEFAULT FAVICON
            nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size) { size in
                print("Set the Default Favicon")
                return image
                
            }
            //TRY AGAIN AFTER SOME TIME
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                if let image = self.playingStation.faviconUIImage {
                    self.nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size) { size in
                        print("Successful second attempt to set remote favicon.")
                        return image
                    }
                }

                self.nowPlayingInfoCenter.nowPlayingInfo = self.nowPlayingInfo
            }
            
            
            
            
        }
        self.nowPlayingInfoCenter.nowPlayingInfo = self.nowPlayingInfo
        
    }
    private func setupRemoteCommandCenter() {
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

    func togglePlayback() {
        if isPlaying {
            isPlaying = false
            pause()
            
        } else {
            
            isPlaying = true
            resume()
        }
    }
    
    func resume() {
        Task {
                await generator.notificationOccurred(.success)
                player.play()
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
    

    
}




