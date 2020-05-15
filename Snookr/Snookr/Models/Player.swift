//
//  Player.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/9/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import Foundation

struct Player {
    var name = playerNamePlaceholder
    var score = 0
    var lastScoreUpdate: Int?
    var secondLastScoreUpdate: Int?
    var thirdLastScoreUpdate: Int?
    var historyUndoable = [Int]()
    var historyRedoable = [Int]()
}
