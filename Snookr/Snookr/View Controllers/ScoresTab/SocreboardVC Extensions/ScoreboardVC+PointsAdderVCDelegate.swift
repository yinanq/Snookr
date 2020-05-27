//
//  ScoreboardVC+.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/14/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

extension ScoreboardVC: PointsAdderVCDelegate {
    
    func didTapAddPointsButton(player: Player, pointsToAdd: Int) {
        switch player.playerId {
        case .player1: give(&player1, pointsToAdd)
        case .player2: give(&player2, pointsToAdd)
        case .unassigned: print("error: .unassigned playerId in didTapAddPointsButton")
        }
        updateScoresView()
        updateResetButton()
    }
    
    private func give(_ player: inout Player, _ points: Int) {
        player.score += points
        persistScoreFor(&player)
        player.historyUndoable.append(points)
        keepUndoHistoryLimitFor(&player)
        updateScoreHistoryViewAndUndoButtonsViewFor(&player)
        clearRedoHistoryAndButtonFor(&player)
        cbNotifyData(of: player)
    }
}
