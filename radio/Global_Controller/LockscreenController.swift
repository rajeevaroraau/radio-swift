//
//  LockscreenController.swift
//  Radio
//
//  Created by Marcin Wolski on 10/12/2023.
//

import Foundation
import MediaPlayer
import OSLog

class LockscreenController  {
    static let shared = LockscreenController()
    
    init() {
        self.nowPlayingInfo = nowPlayingInfoCenter.nowPlayingInfo ?? [String: Any]()
        print("Lockscreen Init complete")
    }
    
    private var nowPlayingInfo: [String: Any]
    private let nowPlayingInfoCenter = MPNowPlayingInfoCenter.default()
    
    func updateInfoCenterWithPlayingStation() async  {
        
        guard let station = PlayingStation.shared.station else {
            print("No station in updateInfoCenterWithPlayingStation()");
            return }
        
        // SET NAME
        nowPlayingInfo[MPMediaItemPropertyTitle] = station.name
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = 0
        nowPlayingInfo[MPNowPlayingInfoPropertyIsLiveStream] = true
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = 1.0
        
        nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
        // SET ARTWORK
        // DEFAULT
        
        tryToSetFaviconForLockScreen()
        // SET THE MPNowPlayingInfoCenter
        await MainActor.run { UIApplication.shared.beginReceivingRemoteControlEvents() }
    }
    
    func tryToSetFaviconForLockScreen() {
        os_signpost(.end, log: pointsOfInterest, name: "Try to set faviconForLockscreen")
        os_signpost(.begin, log: pointsOfInterest, name: "Try to set faviconForLockscreen")
        
        if let faviconUIImage = PlayingStation.shared.faviconUIImage {
            // FIRST ATTEMPT WITH CACHEDIMAGE IF THERE IS IN PLAYINGSTATION
            nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: faviconUIImage.size) { size in
                print("Successful first attempt to set remote favicon.")
                return faviconUIImage
            }
            self.nowPlayingInfoCenter.nowPlayingInfo = self.nowPlayingInfo
            
            
            os_signpost(.end, log: pointsOfInterest, name: "Try to set faviconForLockscreen")
            
            
        } else {
            // SECOND ATTEMPT WITH REQUEST
            
            setDefaultFavicon()
            self.nowPlayingInfoCenter.nowPlayingInfo = self.nowPlayingInfo
            
            
            //TRY AGAIN AFTER SOME TIME WITH REQUESTED FAVICON
            Task {
                // Delay the task by 1 second:
                try await Task.sleep(nanoseconds: 4_000_000_000)
                if let faviconUIImage = PlayingStation.shared.faviconUIImage {
                    self.nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: faviconUIImage.size) { size in
                        print("Successful second attempt to set remote favicon.")
                        return faviconUIImage
                    }
                    await MainActor.run {
                        self.nowPlayingInfoCenter.nowPlayingInfo = self.nowPlayingInfo
                    }
                    
                    os_signpost(.end, log: pointsOfInterest, name: "Try to set faviconForLockscreen")
                } else {
                    os_signpost(.end, log: pointsOfInterest, name: "Try to set faviconForLockscreen")
                }
            }
        }
    }
    
    func setDefaultFavicon() {
        guard let defaultFaviconLarge = UIImage(named: "DefaultFaviconLarge") else  {
            print("No Default UIImage in tryToSetFaviconForLockScreen()");
            return
        }
        nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: defaultFaviconLarge.size) { size in
            print("Set the Default Favicon")
            return defaultFaviconLarge
            
        }
    }
    
    func setupRemoteCommandCenterForLockScreenInput() {
        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.playCommand.isEnabled = true
        commandCenter.playCommand.addTarget { event in
            Task {
                await AudioController.shared.resume()
            }
            return .success
        }
        commandCenter.pauseCommand.isEnabled = true
        commandCenter.pauseCommand.addTarget { event in
            Task {
                await AudioController.shared.pause()
            }
            
            return .success
        }
    }
    
}
