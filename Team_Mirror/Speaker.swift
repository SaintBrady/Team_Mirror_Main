//
//  Speaker.swift
//  Team_Mirror
//
//  Created by Brayden M Dyke on 4/29/23.
//

import Foundation
import AVFoundation

var player: AVAudioPlayer?

class Speaker {
    
    func playSound() {
        guard let path = Bundle.main.path(forResource: "FightSong", ofType: "mp3")
        else {
            print("url not found")
            return
        }
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
