import SwiftUI
import SwiftData
import OSLog

@Observable
class AudioController {
    let logger = Logger(subsystem: "Radio", category: "AudioController")

    static let shared = AudioController()
    

    var setupTask = Task { }

    func prepareStationBaseForPlayback(_ stationBase: StationBase) async {

        let extendedStation = ExtendedStation(stationBase: stationBase, faviconData: nil)
        await playExtendedStation(extendedStation)
        logger.notice("Preparing station finished.")
    }
    
    func playExtendedStation(_ extendedStation: ExtendedStation) async {
        setupTask.cancel()
        setupTask = Task {
            
            logger.info("Started playExtendedStation()")
            
            
            

            await PlayingStation.shared.persistExtendedStation(extendedStation: extendedStation)
            let name = extendedStation.stationBase.name
            logger.info("Trying to play a \(name)")
            // logger.notice("⏩️ notWorking! Continuing \(extendedStation.stationBase.name)")
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
            
            logger.notice("🟩🎉Setup of \(extendedStation.stationBase.name) is done.")
            
        }
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




