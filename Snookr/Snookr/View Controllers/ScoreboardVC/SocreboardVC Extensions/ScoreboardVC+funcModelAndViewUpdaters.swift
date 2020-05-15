//
//  ScoreboardVC+funcModelUpdaters.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/14/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

//func model updaters:

extension ScoreboardVC {
    
    func clearRedoHistoryAndButtonForPlayer1() {
        player1.historyRedoable = []
        stackView.scoreInfoView.undoButtonsView.redoButton1.isHidden = true
    }
    
    func clearRedoHistoryAndButtonForPlayer2() {
        player2.historyRedoable = []
        stackView.scoreInfoView.undoButtonsView.redoButton2.isHidden = true
    }
    
}
