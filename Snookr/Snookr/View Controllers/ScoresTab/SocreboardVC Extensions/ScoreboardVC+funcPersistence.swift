//
//  ScoreboardVC+funcPersistence.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/13/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

extension ScoreboardVC {
    
    func persistScoreFor(_ player: inout Player) {
        var key: String!
        switch player.playerId {
        case .player1: key = SNKCommonKey.player1sScore
        case .player2: key = SNKCommonKey.player2sScore
        case .unassigned: print("error: .unassigned playerId in persistScoreFor")
        }
        if let key = key { defaults.set(player.score, forKey: key) }
    }
    
}
