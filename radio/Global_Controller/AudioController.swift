import SwiftUI
import SwiftData
import OSLog

class AudioController {
    
    
    static let shared = AudioController()
    
    
    // HAPTIC ENGINE
    
    
    
    func playWithSetup() {
        print("===========================")
        print("isPlaying is true")
        
        
        Task {
            
            await MainActor.run {
                os_signpost(.begin, log: pointsOfInterest, name: "Initially Set PlayerState")
                
                PlayerState.shared.isPlaying = true
                PlayerState.shared.firstPlay = false
                os_signpost(.end, log: pointsOfInterest, name: "Initially Set PlayerState")
                
            }
            guard let station = PlayingStation.shared.station else {
                print("No playingStation in playWithSetup");
                pause()
                return
            }
            
            guard let url = URL(string: station.url) else {
                print("Bad url");
                pause()
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
                os_signpost(.begin, log: pointsOfInterest, name: "Save the PlayingStation.shared with mainContext")
                
                do {
                    print("Trying to save...")
                    //            let playingStation = PlayingStation(faviconData: PlayingStation.shared.faviconData, station: PlayingStation.shared.station)
                    //            SwiftDataContainers.shared.container.mainContext.insert(playingStation)
                    
                    try SwiftDataContainers.shared.container.mainContext.save()
                    print("Finished saving the latest station")
                    os_signpost(.end, log: pointsOfInterest, name: "Save the PlayingStation.shared with mainContext")
                    
                } catch {
                    os_signpost(.end, log: pointsOfInterest, name: "Save the PlayingStation.shared with mainContext")
                    
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
        }
        
        
    }
    
    
    func pause() {
        
        Task {
            await MainActor.run {
                PlayerState.shared.isPlaying = false
            }
            AVPlayerController.shared.pause()
            AVAudioSessionController.shared.setActive(false)
            
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




