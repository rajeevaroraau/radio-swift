import SwiftUI
import SwiftData
import OSLog

class AudioController {
    
    static let shared = AudioController()
    var working = false
    
    func playStationBase(_ stationBase: StationBase) async {
        let extendedStation = ExtendedStation(stationBase: stationBase, faviconData: nil)
        await playWithSetupExtendedStation(extendedStation)
    }
    
    func playWithSetupExtendedStation(_ extendedStation: ExtendedStation) async {
        guard working == false else { return }
        working = true
        await PlayingStationManager.shared.setCurrentlyPlayingExtendedStation(extendedStation)
        await MainActor.run {
            PlayerState.shared.playerStateSetup()
        }
        guard let url = URL(string: extendedStation.stationBase.url) else {
            print("Incorrect URL"); await pause(); return
        }
        // PLAY IT
        await AVAudioSessionController.shared.configureAudioSession()
        await AVPlayerController.shared.setupAVPlayerItem(url: url)
        await AVPlayerController.shared.play()
        // SETUP LOCKSCREEN
        await LockscreenController.shared.setupRemoteCommandCenterForLockScreenInput()
        await LockscreenController.shared.updateInfoCenterWithPlayingStation()
        working = false
    }
    
    func resume() async {
        await MainActor.run { PlayerState.shared.isPlaying = true }
        await AVPlayerController.shared.play()
        await AVAudioSessionController.shared.setActive(true)
    }
    
    func pause() async {
        working = false
        await MainActor.run { PlayerState.shared.isPlaying = false }
        await AVPlayerController.shared.pause()
        await AVAudioSessionController.shared.setActive(false)
    }
    
    @MainActor func togglePlayback()   {
        if PlayerState.shared.isPlaying { Task { await pause() }}
        else { Task { await resume() }}
    }
}




