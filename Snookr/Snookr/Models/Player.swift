//
//  Player.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/9/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import Foundation

struct Player {
    
    enum Side {
        case left
        case right
    }
    
    var name = playerNamePlaceholder
    var score = 0
    var historyUndoable = [Int]()
    var historyRedoable = [Int]()
    var side: Side!
    
    init(side: Side) {
        self.side = side
    }
    
}
