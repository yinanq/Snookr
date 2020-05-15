//
//  ScoreboardVC+UndoButtonsViewDelegate.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/12/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

extension ScoreboardVC: UndoButtonsViewDelegate {
    
    func didTapUndoButton(tag: Int) {
        switch tag {
        case SNKButtonTag.undoButton1: didTapUndoButtonFor(&player1)
        case SNKButtonTag.undoButton2: didTapUndoButtonFor(&player2)
        default: print("error: invalid tag in didTapUndoButton")
        }
        updateCommonViews()
    }
    private func didTapUndoButtonFor(_ player: inout Player) {
        guard player.historyUndoable.last != nil else {
            print("error: player's undo button was tappable when undo history was empty, in didTapUndoButtonFor")
            return
        }
        player.score -= player.historyUndoable.last!
        persistScoreFor(&player)
        player.historyRedoable.append(player.historyUndoable.popLast()!)
        updateScoreHistoryViewAndUndoButtonsViewFor(&player)
    }
    
    func didTapRedoButton(tag: Int) {
        switch tag {
        case SNKButtonTag.redoButton1: didTapRedoButtonFor(&player1)
        case SNKButtonTag.redoButton2: didTapRedoButtonFor(&player2)
        default: print("error: invalid tag in didTapRedoButton")
        }
        updateCommonViews()
    }
    private func didTapRedoButtonFor(_ player: inout Player) {
        guard player.historyRedoable.last != nil else {
            print("error: player's redo button was tappable when redo history was empty, in didTapRedoButtonFor")
            return
        }
        player.score += player.historyRedoable.last!
        persistScoreFor(&player)
        player.historyUndoable.append(player.historyRedoable.popLast()!)
        keepRedoHistoryLimitFor(&player)
        updateScoreHistoryViewAndUndoButtonsViewFor(&player)
    }
    
    private func updateCommonViews() {
        updateScoresView()
        updateResetButton()
    }
}
