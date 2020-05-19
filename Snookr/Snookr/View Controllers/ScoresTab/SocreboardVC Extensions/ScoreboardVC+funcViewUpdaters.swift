//
//  ScoreboardVC+funcViewUpdaters.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/13/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

//func view updaters:
extension ScoreboardVC {
    
    func updateResetButton() {
        if player1.score == 0 && player2.score == 0 && player1.historyRedoable.isEmpty && player2.historyRedoable.isEmpty {
            if resetButton.isEnabled || resetButton.alpha != SNKAlpha.disabledButton.rawValue { resetButton.disableOutlineStyleButton() }
        } else {
            if !resetButton.isEnabled || resetButton.alpha != 1 { resetButton.enableOutlineStyleButton() }
        }
    }
    
    func updateNameChangedByModelByOtherVCFor(_ player: inout Player) {
        switch player.playerId {
        case .player1: stackView.scoreInfoView.playerNamesView.textView1.text = player.name
        case .player2: stackView.scoreInfoView.playerNamesView.textView2.text = player.name
        case .unassigned: print("error: .unassigned playerId, updateNameChangedByModelByOtherVCFor")
        }
    }
    
    func updateScoresView() {
        stackView.scoreInfoView.scoresView.scoreLabel1.text = String(player1.score)
        stackView.scoreInfoView.scoresView.scoreLabel2.text = String(player2.score)
        stackView.scoreInfoView.scoresView.scoreDifView.set(difference: abs(player1.score - player2.score))
    }
    
    func updateScoreHistoryViewAndUndoButtonsViewFor(_ player: inout Player) {
        let stack = player.historyUndoable
        let count = stack.count
        let secondLastIndex = count - 2
        let thirdLastIndex = count - 3
        switch player.playerId {
        case .player1:
            if player.historyUndoable.isEmpty {
                stackView.scoreInfoView.undoButtonsView.undoButton1.isHidden = true
            } else if stackView.scoreInfoView.undoButtonsView.undoButton1.isHidden {
                stackView.scoreInfoView.undoButtonsView.undoButton1.isHidden = false
            }
            if !player.historyRedoable.isEmpty {
                stackView.scoreInfoView.undoButtonsView.redoButton1.isHidden = false
            } else if !stackView.scoreInfoView.undoButtonsView.redoButton1.isHidden {
                stackView.scoreInfoView.undoButtonsView.redoButton1.isHidden = true
            }
            if let lastScoreUpdate = stack.last {
                stackView.scoreInfoView.scoreHistoryView.lastScoreUpdateLabel1.text = "+\(lastScoreUpdate)"
            } else {
                stackView.scoreInfoView.scoreHistoryView.lastScoreUpdateLabel1.text = " " //keep empty string to prevent parent stack view from moving subview layout
            }
            if count >= 2 {
                stackView.scoreInfoView.scoreHistoryView.secondLastScoreUpdateLabel1.text = "+\(stack[secondLastIndex])"
            } else {
                stackView.scoreInfoView.scoreHistoryView.secondLastScoreUpdateLabel1.text = " "
            }
            if count >= 3 {
                stackView.scoreInfoView.scoreHistoryView.thirdLastScoreUpdateLabel1.text = "+\(stack[thirdLastIndex])"
            } else {
                stackView.scoreInfoView.scoreHistoryView.thirdLastScoreUpdateLabel1.text = " "
            }
        case .player2:
            if player.historyUndoable.isEmpty {
                stackView.scoreInfoView.undoButtonsView.undoButton2.isHidden = true
            } else if stackView.scoreInfoView.undoButtonsView.undoButton2.isHidden {
                stackView.scoreInfoView.undoButtonsView.undoButton2.isHidden = false
            }
            if !player.historyRedoable.isEmpty {
                stackView.scoreInfoView.undoButtonsView.redoButton2.isHidden = false
            } else if !stackView.scoreInfoView.undoButtonsView.redoButton2.isHidden {
                stackView.scoreInfoView.undoButtonsView.redoButton2.isHidden = true
            }
            if let lastScoreUpdate = stack.last {
                stackView.scoreInfoView.scoreHistoryView.lastScoreUpdateLabel2.text = "+\(lastScoreUpdate)"
            } else {
                stackView.scoreInfoView.scoreHistoryView.lastScoreUpdateLabel2.text = " " //keep empty string to prevent parent stack view from moving subview layout
            }
            if count >= 2 {
                stackView.scoreInfoView.scoreHistoryView.secondLastScoreUpdateLabel2.text = "+\(stack[secondLastIndex])"
            } else {
                stackView.scoreInfoView.scoreHistoryView.secondLastScoreUpdateLabel2.text = " "
            }
            if count >= 3 {
                stackView.scoreInfoView.scoreHistoryView.thirdLastScoreUpdateLabel2.text = "+\(stack[thirdLastIndex])"
            } else {
                stackView.scoreInfoView.scoreHistoryView.thirdLastScoreUpdateLabel2.text = " "
            }
        case .unassigned: print("error: .unassigned playerId in updateScoreHistoryViewAndUndoButtonsViewFor")
        }
    }
}
