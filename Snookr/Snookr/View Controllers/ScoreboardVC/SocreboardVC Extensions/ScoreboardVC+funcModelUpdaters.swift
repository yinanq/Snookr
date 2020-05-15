//
//  ScoreboardVC+funcModelUpdaters.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/14/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

//func model updaters:

extension ScoreboardVC {
    
    func keepUndoHistoryLimitFor(_ player: inout Player) {
        let limit = 100
        if player.historyUndoable.count >= limit {
            player.historyUndoable.removeFirst()
        }
    }
    
    func keepRedoHistoryLimitFor(_ player: inout Player) {
        let limit = 100
        if player.historyRedoable.count >= limit {
            player.historyRedoable.removeFirst()
        }
    }
    
    func clearRedoHistoryAndButtonFor(_ player: inout Player) {
        player.historyRedoable.removeAll()
        switch player.playerId {
        case .player1:
            stackView.scoreInfoView.undoButtonsView.redoButton1.isHidden = true
        case .player2:
            stackView.scoreInfoView.undoButtonsView.redoButton2.isHidden = true
        case .unassigned:
            print("error: .unassigned playerId in clearRedoHistoryAndButtonFor")
        }
    }    
}
