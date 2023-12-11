//
//  LockscreenController.swift
//  Radio
//
//  Created by Marcin Wolski on 10/12/2023.
//

import Foundation
import MediaPlayer


class LockscreenController {
    static let shared = LockscreenController()
    
    init() {
        self.nowPlayingInfo = nowPlayingInfoCenter.nowPlayingInfo ?? [String: Any]()
        print("Lockscreen Init complete")
    }
    
    private var nowPlayingInfo: [String: Any]
    private let nowPlayingInfoCenter = MPNowPlayingInfoCenter.default()
    
    
     func setupRemoteCommandCenter() {
        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.playCommand.isEnabled = true
        commandCenter.playCommand.addTarget { event in
            AudioController.shared.resume()
            return .success
        }
        commandCenter.pauseCommand.isEnabled = true
        commandCenter.pauseCommand.addTarget { event in
            AudioController.shared.pause()
            return .success
        }
    }
    
     func updateInfoCenterWithPlayingStation()  {
        
        guard PlayingStation.shared.station != nil else { 
            print("No station in updateInfoCenterWithPlayingStation()");
            return }
        
        // SET NAME
        nowPlayingInfo[MPMediaItemPropertyTitle] = PlayingStation.shared.station!.name
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = 0
        nowPlayingInfo[MPNowPlayingInfoPropertyIsLiveStream] = true
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = 1.0
        
        nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
        // SET ARTWORK
        // DEFAULT
        Task {
            await tryToSetFaviconForLockScreen()
        }
        
        
        // SET THE MPNowPlayingInfoCenter
        nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
        DispatchQueue.main.async {
            UIApplication.shared.beginReceivingRemoteControlEvents()
        }
    }
     func tryToSetFaviconForLockScreen() async {
        // FIRST ATTEMPT WITH CACHEDIMAGE
        if let image = PlayingStation.shared.faviconUIImage {
            nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size) { size in
                print("Successful first attempt to set remote favicon.")
                return image
            }
            
        // SECOND ATTEMPT WITH REQUEST
        } else {
            
            // FIRST LET's SET TEMPORARY DEFAULT FAVICON
            guard let image = UIImage(named: "DefaultFaviconLarge") else  {
                print("No Default UIImage in tryToSetFaviconForLockScreen()");
                return
            }
            nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size) { size in
                print("Set the Default Favicon")
                return image
                
            }
            
            //TRY AGAIN AFTER SOME TIME WITH REQUESTED FAVICON
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                if let image = PlayingStation.shared.faviconUIImage {
                    self.nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size) { size in
                        print("Successful second attempt to set remote favicon.")
                        return image
                    }
                }
                
                self.nowPlayingInfoCenter.nowPlayingInfo = self.nowPlayingInfo
            }
        }
         
         // UPDATE THE INFO
        self.nowPlayingInfoCenter.nowPlayingInfo = self.nowPlayingInfo
    }
}
