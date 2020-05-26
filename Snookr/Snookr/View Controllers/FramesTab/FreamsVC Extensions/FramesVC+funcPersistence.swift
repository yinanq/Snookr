//
//  FramesVC+funcPersistence.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/18/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

//func persistence:
extension FramesVC {
    
    func persistFramesWon(of player: inout Player) {
        var keyString: String!
        switch player.playerId {
        case .player1: keyString = Key.player1sFramesWon
        case .player2: keyString = Key.player2sFramesWon
        case .unassigned: print("error: .unassigned playerId in persistScoreFor")
        }
        if let ks = keyString { defaults.set(player.framesWon, forKey: ks) }
    }
    
}
