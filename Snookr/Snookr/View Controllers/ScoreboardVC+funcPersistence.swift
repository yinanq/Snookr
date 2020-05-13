//
//  ScoreboardVC+funcPersistence.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/13/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

extension ScoreboardVC {
    
    func persistScoresOfBothPlayers() {
        persistScoreOfPlayer1()
        persistScoreOfPlayer2()
    }
    
    func persistScoreOfPlayer1() { defaults.set(player1.score, forKey: Key.player1sScore) }
    
    func persistScoreOfPlayer2() { defaults.set(player2.score, forKey: Key.player2sScore) }
}
