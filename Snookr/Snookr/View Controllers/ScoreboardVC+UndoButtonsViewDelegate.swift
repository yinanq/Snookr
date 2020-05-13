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
            player1.score -= player1.lastScoreUpdate
            player1.lastScoreUpdate = player1.secondLastScoreUpdate
            player1.secondLastScoreUpdate = player1.thirdLastScoreUpdate
            player1.thirdLastScoreUpdate = 0
            updateScoreHistoryViewsOfPlayer1()
        case SNKButtonTag.undoButton2:
            player2.score -= player2.lastScoreUpdate
            player2.lastScoreUpdate = player2.secondLastScoreUpdate
            player2.secondLastScoreUpdate = player2.thirdLastScoreUpdate
            player2.thirdLastScoreUpdate = 0
            updateScoreHistoryViewsOfPlayer2()
        default: print("error: invalid tag in didTapUndoButton")
        }
        updateScoreViews()
    }

}
