//
//  AudioPlayer.swift
//  RestartApp
//
//  Created by Yusril on 18/01/23.
//

import Foundation
import AVKit

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("Cannot play this sound.")
        }
    }
}
