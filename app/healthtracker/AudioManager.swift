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
            //print("error playing audio")
        }
        
        let session = AVAudioSession.sharedInstance()
        
        do {
            try session.setCategory(AVAudioSessionCategoryPlayback)
        } catch {
            //print("error playing audio in background")
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
    
    func getDuration(name: String) -> Double {
        let audioPath = Bundle.main.path(forResource: name, ofType: "mp3")
        
        let asset = AVURLAsset(url: NSURL(fileURLWithPath: audioPath!) as URL, options: nil)
        let audioDuration = asset.duration
        return CMTimeGetSeconds(audioDuration)
    }
}
