//
//  ScoreboardVC+funcPersistence.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/13/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

extension ScoreboardVC {
    
    func persistScoreFor(_ player: inout Player) {
        
        var keyString: String!
        
        switch player.playerId {
        case .player1:
            keyString = Key.player1sScore
        case .player2:
            keyString = Key.player2sScore
        case .unassigned:
            print("error: .unassigned playerId in persistScoreFor")
            return
        }
        
        defaults.set(player.score, forKey: keyString)
    }
    
}
