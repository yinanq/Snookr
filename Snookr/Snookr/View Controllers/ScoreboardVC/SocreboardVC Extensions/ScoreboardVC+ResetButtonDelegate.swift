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
        player1.historyUndoable.removeAll()
        player1.historyRedoable.removeAll()
        player2.historyUndoable.removeAll()
        player2.historyRedoable.removeAll()
        //update (model and) view:
        updateScoresView()
        updateScoreHistoryViewAndUndoButtonsViewFor(&player1)
        updateScoreHistoryViewAndUndoButtonsViewFor(&player2)
        clearRedoHistoryAndButtonFor(&player1)
        clearRedoHistoryAndButtonFor(&player2)
        updateResetButton()
        //persist:
        persistScoreFor(&player1)
        persistScoreFor(&player2)
    }
}
