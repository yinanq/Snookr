//
//  ScoreboardVC+.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/14/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

extension ScoreboardVC: PointsAdderVCDelegate {
    func didTapAddPointsButton(player: Player, pointsToAdd: Int) {
        switch player.name {
            
        case player1.name:
            player1.score += pointsToAdd
            persistScoreOfPlayer1()
            player1.historyUndoable.append(pointsToAdd)
            updateScoreHistoryViewAndUndoButtonsViewOfPlayer1()
            clearRedoHistoryAndButtonForPlayer1()
            
        case player2.name:
            player2.score += pointsToAdd
            persistScoreOfPlayer2()
            player2.historyUndoable.append(pointsToAdd)
            updateScoreHistoryViewAndUndoButtonsViewOfPlayer2()
            clearRedoHistoryAndButtonForPlayer2()
            
        default: print("error: invalid player in didTapAddPointsButton")
        }
        updateScoresView()
        updateResetButton()
    }
}
