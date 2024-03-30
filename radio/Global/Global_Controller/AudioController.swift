import SwiftUI
import SwiftData
import OSLog

@Observable
class AudioController {
    let logger = Logger(subsystem: "Radio", category: "AudioController")

    static let shared = AudioController()
    var working = false
    func workingOn()  {
        working = true
        logger.info("Great. AudioController is now working")

    }
    func workingOff()  {
        working = false
        logger.info("AudioController no longer working")
    }
    
    func prepareStationBaseForPlayback(_ stationBase: StationBase) async {
        guard working == false else {
            logger.notice("🟥Player is already Working")
            return
        }
        workingOn()
        let extendedStation = ExtendedStation(stationBase: stationBase, faviconData: nil)
        workingOff()
        await playWithSetupExtendedStation(extendedStation)
    }
    
    func playWithSetupExtendedStation(_ extendedStation: ExtendedStation) async {
        logger.info("🟩🏁Trying to play \(extendedStation.stationBase.name)")
        guard  working == false else { 
            logger.notice("🟥The player is already Working")
            return
        }
        logger.notice("⏩️ notWorking! Continuing \(extendedStation.stationBase.name)")
        workingOn()
        await PlayingStation.shared.setCurrentlyPlayingExtendedStation(extendedStation)
        await MainActor.run { PlayerState.shared.playerStateSetup(extendedStation) }
        guard let url = URL(string: extendedStation.stationBase.url) else {
            logger.error("Couldn't create URL - \(extendedStation.stationBase.name): \(extendedStation.stationBase.url)")
            await pause()
            return
        }
        // PLAY IT
        await AVAudioSessionController.shared.configureAudioSession()
        await AVPlayerController.shared.setupAVPlayerItem(url: url)
        await AVPlayerController.shared.play()
        // SETUP LOCKSCREEN
        await LockscreenController.shared.setupRemoteCommandCenterForLockScreenInput()
        await LockscreenController.shared.updateInfoCenterWithPlayingStation()
        
        workingOff()
        logger.notice("🟩🎉Setup of \(extendedStation.stationBase.name) is done.")

    }
    
    func resume() async {
        await MainActor.run { PlayerState.shared.isPlaying = true }
        await AVPlayerController.shared.play()
        await AVAudioSessionController.shared.setActive(true)
    }
    
    func pause() async {
        await MainActor.run { PlayerState.shared.isPlaying = false }
        await AVPlayerController.shared.pause()
        await AVAudioSessionController.shared.setActive(false)
    }
    
    @MainActor func togglePlayback()   {
        if PlayerState.shared.isPlaying { Task { await pause() }}
        else { Task { await resume() }}
    }
}




