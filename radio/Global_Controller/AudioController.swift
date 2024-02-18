import SwiftUI
import SwiftData
import OSLog

class AudioController {
    
    
    static let shared = AudioController()
    
    
    // HAPTIC ENGINE
    
    
    // MARK: PLAY WITH SETUP
    
    func playWithSetupStationBase(_ stationBase: StationBase) async {
        let extendedStation = ExtendedStation(stationBase: stationBase)
        await playWithSetupExtendedStation(extendedStation)
    }
    
    func playWithSetupExtendedStation(_ extendedStation: ExtendedStation) async {
        
        // MARK: CACHE PLAYINGSTATION
        await MainActor.run {
            
            
            PlayingStationManager.shared.setCurrentlyPlayingExtendedStation(extendedStation: extendedStation)

            os_signpost(.begin, log: pointsOfInterest, name: "Save the PlayingStation.shared with mainContext")
            do {

                os_signpost(.end, log: pointsOfInterest, name: "Save the PlayingStation.shared with mainContext")
                
            } catch {
                os_signpost(.end, log: pointsOfInterest, name: "Save the PlayingStation.shared with mainContext")
                print("Cannot save")
            }
        }
        
        
        os_signpost(.begin, log: pointsOfInterest, name: "Initially Set PlayerState")
        await MainActor.run {
            PlayerState.shared.isPlaying = true
            PlayerState.shared.firstPlay = false
            os_signpost(.end, log: pointsOfInterest, name: "Initially Set PlayerState")
            
        }
        guard let url = URL(string: extendedStation.stationBase.url) else {
            print("Bad url");
            Task {
                await pause()
            }
            return
        }
        
        // MARK: SETUP AUDIOSESSION
        
        AVAudioSessionController.shared.configureAudioSession()
        // SETUP AVPlayerItem
        AVPlayerController.shared.setupAVPlayerItem(url: url)
        // RESUME URL STREAM WITH AVPLAYER
        AVPlayerController.shared.play()
        
        // MARK: SETUP LOCKSCREEN
        LockscreenController.shared.setupRemoteCommandCenterForLockScreenInput()
        await LockscreenController.shared.updateInfoCenterWithPlayingStation()

        //        do {
        //            print("Trying to delete...")
        //            if let stationToDelete = try? SwiftDataContainers.shared.container.mainContext.fetch(FetchDescriptor<PlayingStation>()).last {
        //                if
        //            }
        //        } catch {
        //            fatalError("Can't delete")
        //        }
        //


        
    }
    
    
    // MARK: DEF RESUME()
    func resume() async {
            await MainActor.run { PlayerState.shared.isPlaying = true }
            AVPlayerController.shared.play()
            AVAudioSessionController.shared.setActive(true)
        
    }
    
    // MARK: DEF PAUSE()

    func pause() async {
            await MainActor.run {
                PlayerState.shared.isPlaying = false
            }
            AVPlayerController.shared.pause()
            AVAudioSessionController.shared.setActive(false)
    }
    
    // MARK: DEF TOGGLEPLAYBACK()

    @MainActor func togglePlayback() {
        if PlayerState.shared.isPlaying {
            Task {
                await pause()
            }
            
        } else {
            Task {
                await resume()
            }
            
        }
    }
}




