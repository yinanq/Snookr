//
//  FramesVC+funcPersistence.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/18/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

extension FramesVC {
    
    func persistFramesWon(of player: inout Player) {
        var key: String!
        switch player.playerId {
        case .player1: key = SNKCommonKey.player1sFrame
        case .player2: key = SNKCommonKey.player2sFrame
        case .unassigned: print("error: .unassigned playerId in persistScoreFor")
        }
        if let key = key { defaults.set(player.framesWon, forKey: key) }
    }
    
}
