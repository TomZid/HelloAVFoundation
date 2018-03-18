//
//  TZPlayerManager.swift
//  Audio_Looper
//
//  Created by Tom.Zid on 18/03/2018.
//  Copyright © 2018 TZ. All rights reserved.
//

import Foundation
import AVFoundation

enum PlayerCurrentState {
    case playing
    case stop
}

class PlayerManger {
    
    var currentState = PlayerCurrentState.stop
    var audioPlayers = [AVAudioPlayer]()
    
    init() {
        self.makePlayers()
    }
    
    func makePlayers() {
        let guitarPlayer = self.playerForFile(filename: "guitar")
        let bassPlayer = self.playerForFile(filename: "bass")
        let drumsPlayer = self.playerForFile(filename: "drums")
        
        audioPlayers = [guitarPlayer!, bassPlayer!, drumsPlayer!]
    }
    
    func playerForFile(filename name: String) -> AVAudioPlayer? {
        if let url = Bundle.main.url(forResource: name, withExtension: "caf") {
            do {
                let player = try AVAudioPlayer.init(contentsOf: url)
                return player
            }catch {}
        }
        return nil
    }

    func playAll() {
        let interval = self.audioPlayers[0].deviceCurrentTime + 0.01
        for player in self.audioPlayers {
            player.play(atTime: interval)
            player.numberOfLoops = -1
            
            self.currentState = .playing
        }
    }
    
    func stopAll() {
        for player in self.audioPlayers {
            player.stop()
            player.currentTime = 0
            
            self.currentState = .stop
        }
    }
    
}
