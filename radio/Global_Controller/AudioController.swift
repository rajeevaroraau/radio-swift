import SwiftUI
import SwiftData


class AudioController {
    
    
    static let shared = AudioController()
    
    
    // HAPTIC ENGINE
    
    
    
    func playWithSetup() {
        print("===========================")
        print("isPlaying is true")
        


        
        
        
        Task {
            await MainActor.run {
                PlayerState.shared.isPlaying = true
                PlayerState.shared.firstPlay = false
            }
            guard let station = PlayingStation.shared.station else {
                print("No playingStation in playWithSetup");
                await MainActor.run {
                    PlayerState.shared.isPlaying = false;
                }
                
                return
            }
            
            guard let url = URL(string: station.url) else {
                print("Bad url");
                await MainActor.run {
                    PlayerState.shared.isPlaying = false;
                }
                return
            }
            
            // SETUP AUDIOSESSION
            AVAudioSessionController.shared.configureAudioSession()
            // SETUP AVPlayerItem
            AVPlayerController.shared.setupAVPlayerItem(url: url)
            // RESUME URL STREAM WITH AVPLAYER
            AVPlayerController.shared.play()
            LockscreenController.shared.setupRemoteCommandCenter()
            LockscreenController.shared.updateInfoCenterWithPlayingStation()
            
            
            
            
            //        do {
            //            print("Trying to delete...")
            //            if let stationToDelete = try? SwiftDataContainers.shared.container.mainContext.fetch(FetchDescriptor<PlayingStation>()).last {
            //                if
            //            }
            //        } catch {
            //            fatalError("Can't delete")
            //        }
            //
            await MainActor.run {
                do {
                    print("Trying to save...")
                    //            let playingStation = PlayingStation(faviconData: PlayingStation.shared.faviconData, station: PlayingStation.shared.station)
                    //            SwiftDataContainers.shared.container.mainContext.insert(playingStation)
                    
                    try SwiftDataContainers.shared.container.mainContext.save()
                    print("Finished saving the latest station")
                } catch {
                    print("Cannot save")
                }
            }
        }
    }
    
    
    
    func resume() {
    
        
        Task {
            await MainActor.run {
                PlayerState.shared.isPlaying = true
            }
            AVPlayerController.shared.play()
            AVAudioSessionController.shared.setActive(true)
            hapticFeedback()
        }
        
        
    }
    
    
     func pause() {
        
         Task {
             await MainActor.run {
                 PlayerState.shared.isPlaying = false
             }
            AVPlayerController.shared.pause()
            AVAudioSessionController.shared.setActive(false)
            hapticFeedback()
        }
        
        
    }
    
    @MainActor func togglePlayback() {
        if PlayerState.shared.isPlaying {
            pause()
        } else {
            resume()
        }
    }
}




