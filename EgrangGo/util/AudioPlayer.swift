//
//  AudioPlayer.swift
//  EgrangGo
//
//  Created by Nathanael Juan Gauthama on 21/05/24.
//

import Foundation
import AVFoundation

private var audioPlayer: AVAudioPlayer? = nil
private var sfxPlayer: AVAudioPlayer? = nil

func playAudio(audioResourceId: String, isLoop: Bool) {
    Task{
        if let fileName = Bundle.main.path(forResource: audioResourceId, ofType: "wav") {
            audioPlayer = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileName))
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch(let error) {
            print(error.localizedDescription)
        }
        audioPlayer?.numberOfLoops = (isLoop) ? -1 : 0
        audioPlayer?.play()
    }
}

func stopAudio(){
    audioPlayer?.stop()
}

func playSFX(audioResourceId: String, isLoop: Bool) {
    Task{
        if let fileName = Bundle.main.path(forResource: audioResourceId, ofType: "wav") {
            audioPlayer = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileName))
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch(let error) {
            print(error.localizedDescription)
        }
        audioPlayer?.numberOfLoops = (isLoop) ? -1 : 0
        audioPlayer?.play()
    }
}

func stopSFX() {
    sfxPlayer?.stop()
}
