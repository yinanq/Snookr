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
            
        case SNKButtonTag.undoButton1:
            player1.score -= player1.historyUndoable.last!
            persistScoreOfPlayer1()
            player1.historyUndoable.removeLast()
            updateScoreHistoryViewAndUndoButtonsViewOfPlayer1()
            
        case SNKButtonTag.undoButton2:
            player2.score -= player2.historyUndoable.last!
            persistScoreOfPlayer2()
            player2.historyUndoable.removeLast()
            updateScoreHistoryViewAndUndoButtonsViewOfPlayer2()
            
        default: print("error: invalid tag in didTapUndoButton")
        }
        
        updateScoresView()
        updateResetButton()
    }
}
