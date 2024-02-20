import SwiftUI
import SwiftData
import OSLog

class AudioController {
    
    static let shared = AudioController()
    
    func playWithSetupStationBase(_ stationBase: StationBase) async {
        let extendedStation = ExtendedStation(stationBase: stationBase)
        await playWithSetupExtendedStation(extendedStation)
    }
    
    func playWithSetupExtendedStation(_ extendedStation: ExtendedStation) async {
        await MainActor.run { PlayingStationManager.shared.setCurrentlyPlayingExtendedStation(extendedStation: extendedStation) }
        await PlayerState.shared.playerStateSetup()
        guard let url = URL(string: extendedStation.stationBase.url) else {
            print("Bad url");
            Task { await pause() }
            return
        }
        AVAudioSessionController.shared.configureAudioSession()
        AVPlayerController.shared.setupAVPlayerItem(url: url)
        AVPlayerController.shared.play()
        // MARK: SETUP LOCKSCREEN
        LockscreenController.shared.setupRemoteCommandCenterForLockScreenInput()
        await LockscreenController.shared.updateInfoCenterWithPlayingStation()
    }
    
    func resume() async {
        await MainActor.run { PlayerState.shared.isPlaying = true }
        AVPlayerController.shared.play()
        AVAudioSessionController.shared.setActive(true)
    }
    
    func pause() async {
        await MainActor.run { PlayerState.shared.isPlaying = false }
        AVPlayerController.shared.pause()
        AVAudioSessionController.shared.setActive(false)
    }
    
     func togglePlayback() async {
         if await PlayerState.shared.isPlaying { await pause() } else { await resume() }
    }
    
}




