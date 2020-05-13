//
//  ScoreboardVC+ResetButtonDelegate.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/13/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

extension ScoreboardVC: ResetButtonDelegate {
    func didTapResetButton() {
        player1.score = 0
        player2.score = 0
        updateScoresView()
        player1.lastScoreUpdate = nil
        player1.secondLastScoreUpdate = nil
        player1.thirdLastScoreUpdate = nil
        player2.lastScoreUpdate = nil
        player2.secondLastScoreUpdate = nil
        player2.thirdLastScoreUpdate = nil
        updateScoreHistoryViewAndUndoButtonsViewOfPlayer1()
        updateScoreHistoryViewAndUndoButtonsViewOfPlayer2()
    }
}
