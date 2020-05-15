//
//  ScoreboardVC+ScoreButtonsViewDelegate.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/12/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

extension ScoreboardVC: ScoreButtonsViewDelegate {

    func didTapScoreButton(tag: Int) {
        switch tag {
        case SNKButtonTag.plusButton1, SNKButtonTag.plusButton2: openPointsAdderVCForPlayerWith(buttonTag: tag)
        case SNKButtonTag.plusOneButton1, SNKButtonTag.plusOneButton2: addOneToScoreOfPlayerWith(buttonTag: tag)
        default: print("error: invalid tag in didTapScoreButton")
        }
    }
    
    private func openPointsAdderVCForPlayerWith(buttonTag: Int) {
        var pointsAdderVC: PointsAdderVC!
        switch buttonTag {
        case SNKButtonTag.plusButton1:
            pointsAdderVC = PointsAdderVC(player: player1)
        case SNKButtonTag.plusButton2:
            pointsAdderVC = PointsAdderVC(player: player2)
        default: print("error: invalid tag in openPointsAdderVC")
        }
        pointsAdderVC.delegate = self
        present(pointsAdderVC, animated: true)
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
        updateResetButton()
    }
    
}
