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
    
    //torefactor
    private func addOneToScoreOfPlayerWith(buttonTag: Int) {
        switch buttonTag {
        case SNKButtonTag.plusOneButton1:
            player1.score += 1
            persistScoreFor(&player1)
            player1.historyUndoable.append(1)
            updateScoreHistoryViewAndUndoButtonsViewFor(&player1)
            keepUndoHistoryLimitFor(&player1)
            clearRedoHistoryAndButtonFor(&player1)
        case SNKButtonTag.plusOneButton2:
            player2.score += 1
            persistScoreFor(&player2)
            player2.historyUndoable.append(1)
            updateScoreHistoryViewAndUndoButtonsViewFor(&player2)
            keepUndoHistoryLimitFor(&player2)
            clearRedoHistoryAndButtonFor(&player2)
        default: print("error: invalid tag in addOneToScoreOfPlayer")
        }
        updateScoresView()
        updateResetButton()
    }
    //torefactor
    private func addOnePointFor(_ player: inout Player) {
        player.score += 1
        //
        player.historyUndoable.append(1)
        updateScoreHistoryViewAndUndoButtonsViewFor(&player)
        keepUndoHistoryLimitFor(&player)
        clearRedoHistoryAndButtonFor(&player)
        updateScoresView()
        updateResetButton()
    }
    
}
