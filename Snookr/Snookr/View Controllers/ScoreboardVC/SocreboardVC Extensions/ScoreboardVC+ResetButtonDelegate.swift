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
        player1.lastScoreUpdate = nil
        player1.secondLastScoreUpdate = nil
        player1.thirdLastScoreUpdate = nil
        player2.lastScoreUpdate = nil
        player2.secondLastScoreUpdate = nil
        player2.thirdLastScoreUpdate = nil
        //update view:
        updateScoresView()
        updateScoreHistoryViewAndUndoButtonsViewOfPlayer1()
        updateScoreHistoryViewAndUndoButtonsViewOfPlayer2()
        updateResetButton()
        //persist:
        persistScoresOfBothPlayers()
    }
}
