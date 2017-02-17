//
//  AudioManager.swift
//  healthtracker
//
//  Created by untitled on 15/2/17.
//
//

import Foundation
import AVFoundation

class AudioManager: NSObject {
    static let sharedInstance: AudioManager = {
        let instance = AudioManager()
        return instance
    }()
    
    var audioPlayer = AVAudioPlayer()
    
    func playAudio(name: String) {
        do {
            let audioPath = Bundle.main.path(forResource: name, ofType: "mp3")
            
            audioPlayer = try AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            audioPlayer.prepareToPlay()
        } catch {
            print("error playing audio")
        }
        
        audioPlayer.play()
    }
    
    func stopAudio() {
        if (audioPlayer.isPlaying) {
            audioPlayer.stop()
        }
    }
    
    func isPlaying() -> Bool {
        if (audioPlayer.isPlaying) {
            return true
        }
        
        return false
    }
}
