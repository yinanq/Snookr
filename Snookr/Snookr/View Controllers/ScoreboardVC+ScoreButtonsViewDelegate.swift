//
//  ScoreboardVC+ScoreButtonsViewDelegate.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/12/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

extension ScoreboardVC: ScoreButtonsViewDelegate {
    
    func didTapScoreButton(tag: Int) {
        switch tag {
        case SNKButtonTag.plusButton1, SNKButtonTag.plusButton2: print("tapped one of the big +n buttons")
        case SNKButtonTag.plusOneButton1, SNKButtonTag.plusOneButton2: addOneToScoreOfPlayerWith(buttonTag: tag)
        default: print("error: invalid tag in didTapScoreButton")
        }
    }
    
    private func addOneToScoreOfPlayerWith(buttonTag: Int) {
        switch buttonTag {
        case SNKButtonTag.plusOneButton1:
            player1.score += 1
            player1.thirdLastScoreUpdate = player1.secondLastScoreUpdate
            player1.secondLastScoreUpdate = player1.lastScoreUpdate
            player1.lastScoreUpdate = 1
            updateScoreHistoryViewAndUndoButtonsViewOfPlayer1()
            persistScoreOfPlayer1()
        case SNKButtonTag.plusOneButton2:
            player2.score += 1
            player2.thirdLastScoreUpdate = player2.secondLastScoreUpdate
            player2.secondLastScoreUpdate = player2.lastScoreUpdate
            player2.lastScoreUpdate = 1
            updateScoreHistoryViewAndUndoButtonsViewOfPlayer2()
            persistScoreOfPlayer2()
        default: print("error: invalid tag in addOneToScoreOfPlayer")
        }
        updateScoresView()
    }
    
}
