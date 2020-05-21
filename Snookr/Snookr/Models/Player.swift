//
//  Player.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/9/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import Foundation

struct Player {
    
    enum PlayerId {
        case player1
        case player2
        case unassigned
    }
    
    var name = "Player Name"
    var score = 0
    var framesWon = 0
    var historyUndoable = [Int]()
    var historyRedoable = [Int]()
    var playerId = PlayerId.unassigned
    
    init(playerId: PlayerId) {
        self.playerId = playerId
    }
    
}
