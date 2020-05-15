//
//  ScoreboardVC+ResetButtonDelegate.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/13/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

extension ScoreboardVC: ResetButtonDelegate {
    func didTapResetButton() {
        //update model:
        player1.score = 0
        player2.score = 0
        player1.historyUndoable = []
        player1.historyRedoable = []
        player2.historyUndoable = []
        player2.historyRedoable = []
        //update view:
        updateScoresView()
        updateScoreHistoryViewAndUndoButtonsViewOfPlayer1()
        updateScoreHistoryViewAndUndoButtonsViewOfPlayer2()
        updateResetButton()
        //persist:
        persistScoresOfBothPlayers()
    }
}
