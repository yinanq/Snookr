//
//  ScoreboardVC+UndoButtonsViewDelegate.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/12/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

extension ScoreboardVC: UndoButtonsViewDelegate {
    
    func didTapUndoButton(tag: Int) {
        switch tag {
        case SNKButtonTag.undoButton1:
            guard let lastScoreUpdate = player1.lastScoreUpdate else { return }
            player1.score -= lastScoreUpdate
            player1.lastScoreUpdate = player1.secondLastScoreUpdate
            player1.secondLastScoreUpdate = player1.thirdLastScoreUpdate
            player1.thirdLastScoreUpdate = nil
            updateScoreHistoryViewAndUndoButtonsViewOfPlayer1()
            persistScoreOfPlayer1()
        case SNKButtonTag.undoButton2:
            guard let lastScoreUpdate = player2.lastScoreUpdate else { return }
            player2.score -= lastScoreUpdate
            player2.lastScoreUpdate = player2.secondLastScoreUpdate
            player2.secondLastScoreUpdate = player2.thirdLastScoreUpdate
            player2.thirdLastScoreUpdate = nil
            updateScoreHistoryViewAndUndoButtonsViewOfPlayer2()
            persistScoreOfPlayer2()
        default: print("error: invalid tag in didTapUndoButton")
        }
        updateScoresView()
    }

}
