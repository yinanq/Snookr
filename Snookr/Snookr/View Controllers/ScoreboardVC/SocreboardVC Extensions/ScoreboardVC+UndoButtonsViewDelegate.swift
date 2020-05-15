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
            guard player1.historyUndoable.last != nil else {
                print("error: player 1's undo button tapped when history is empty")
                return
            }
            player1.score -= player1.historyUndoable.last!
            persistScoreOfPlayer1()
            player1.historyRedoable.append(player1.historyUndoable.popLast()!)
            updateScoreHistoryViewAndUndoButtonsViewOfPlayer1()
            
        case SNKButtonTag.undoButton2:
            guard player2.historyUndoable.last != nil else {
                print("error: player 2's undo button tapped when history is empty")
                return
            }
            player2.score -= player2.historyUndoable.last!
            persistScoreOfPlayer2()
            player2.historyRedoable.append(player2.historyUndoable.popLast()!)
            updateScoreHistoryViewAndUndoButtonsViewOfPlayer2()
            
        default: print("error: invalid tag in didTapUndoButton")
        }
        updateOtherViews()
    }
    
    func didTapRedoButton(tag: Int) {
        switch tag {
        case SNKButtonTag.redoButton1:
            guard player1.historyRedoable.last != nil else {
                print("error: player 1's redo button tapped when nothing had been undone")
                return
            }
            player1.score += player1.historyRedoable.last!
            persistScoreOfPlayer1()
            
            player1.historyUndoable.append(player1.historyRedoable.popLast()!)
            updateScoreHistoryViewAndUndoButtonsViewOfPlayer1()
            
        case SNKButtonTag.redoButton2:
            guard player2.historyRedoable.last != nil else {
                print("error: player 2's redo button tapped when nothing had been undone")
                return
            }
            player2.score += player2.historyRedoable.last!
            persistScoreOfPlayer2()
            
            player2.historyUndoable.append(player2.historyRedoable.popLast()!)
            updateScoreHistoryViewAndUndoButtonsViewOfPlayer2()
            
        default: print("error: invalid tag in didTapRedoButton")
        }
        updateOtherViews()
    }
    
    private func updateOtherViews() {
        updateScoresView()
        updateResetButton()
    }
}
