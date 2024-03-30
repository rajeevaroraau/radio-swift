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
        // SET NAME
        nowPlayingInfo[MPMediaItemPropertyTitle] = PlayingStation.shared.currentlyPlayingExtendedStation?.stationBase.name ?? "Nothing Playing"
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = 0
        nowPlayingInfo[MPNowPlayingInfoPropertyIsLiveStream] = true
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = 1.0
        nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
        // SET ARTWORK
        // DEFAULT
        await tryToSetFaviconForLockScreen()
        // SET THE MPNowPlayingInfoCenter
        await UIApplication.shared.beginReceivingRemoteControlEvents()
    }
    
    func tryToSetFaviconForLockScreen() async {
        os_signpost(.end, log: pointsOfInterest, name: "Try to set faviconForLockscreen")
        os_signpost(.begin, log: pointsOfInterest, name: "Try to set faviconForLockscreen")
        
        if let faviconUIImageLocal = PlayingStation.shared.currentlyPlayingExtendedStation?.faviconProducts.uiImage {
            // FIRST ATTEMPT WITH CACHEDIMAGE IF THERE IS IN PLAYINGSTATION
            nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: faviconUIImageLocal.size) { size in
                print("Successful first attempt to set remote favicon.")
                return faviconUIImageLocal
            }
            self.nowPlayingInfoCenter.nowPlayingInfo = self.nowPlayingInfo
            os_signpost(.end, log: pointsOfInterest, name: "Try to set faviconForLockscreen")
        } else {
            // SECOND ATTEMPT WITH REQUEST
            await setDefaultFavicon()
            self.nowPlayingInfoCenter.nowPlayingInfo = self.nowPlayingInfo
            //TRY AGAIN AFTER SOME TIME WITH REQUESTED FAVICON
            // Delay the task by 1 second:
            try? await Task.sleep(nanoseconds: 4_000_000_000)
            if let faviconUIImage = PlayingStation.shared.currentlyPlayingExtendedStation?.faviconProducts.uiImage {
                self.nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: faviconUIImage.size) { size in
                    print("Successful second attempt to set remote favicon.")
                    return faviconUIImage
                }
                self.nowPlayingInfoCenter.nowPlayingInfo = self.nowPlayingInfo
                
                os_signpost(.end, log: pointsOfInterest, name: "Try to set faviconForLockscreen")
            } else {
                os_signpost(.end, log: pointsOfInterest, name: "Try to set faviconForLockscreen")
            }
            
        }
    }
    
    func setDefaultFavicon() async {
        guard let defaultFaviconLarge = UIImage(named: "DefaultFaviconLarge") else { print("No Default UIImage in tryToSetFaviconForLockScreen()"); return }
        nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: defaultFaviconLarge.size) { size in
            print("Set the Default Favicon")
            return defaultFaviconLarge
        }
    }
    
    func setupRemoteCommandCenterForLockScreenInput() async {
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
