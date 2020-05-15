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
        if player1.score == 0 && player2.score == 0 {
            resetButton.isEnabled = false
            resetButton.alpha = SNKAlpha.transparentLowOpacity.rawValue
        } else if resetButton.isEnabled == false {
            resetButton.isEnabled = true
            resetButton.alpha = 1
        }
    }
    
    func updateScoresView() {
        stackView.scoreInfoView.scoresView.scoreLabel1.text = String(player1.score)
        stackView.scoreInfoView.scoresView.scoreLabel2.text = String(player2.score)
        stackView.scoreInfoView.scoresView.scoreDifView.set(difference: abs(player1.score - player2.score))
    }
    
    func updateScoreHistoryViewAndUndoButtonsViewOfPlayer1() {
        //undo button:
        if player1.historyUndoable.isEmpty {
            stackView.scoreInfoView.undoButtonsView.undoButton1.isHidden = true
        } else if stackView.scoreInfoView.undoButtonsView.undoButton1.isHidden {
            stackView.scoreInfoView.undoButtonsView.undoButton1.isHidden = false
        }
        //undoable history labels:
        let stack = player1.historyUndoable
        let count = stack.count
        let secondLastIndex = count - 2
        let thirdLastIndex = count - 3
        if let lastScoreUpdate = player1.historyUndoable.last {
            stackView.scoreInfoView.scoreHistoryView.lastScoreUpdateLabel1.text = "+\(lastScoreUpdate)"
        } else {
            stackView.scoreInfoView.scoreHistoryView.lastScoreUpdateLabel1.text = " " //keep empty string to prevent parent stack view from moving subview layout
        }
        if count >= 2 {
            stackView.scoreInfoView.scoreHistoryView.secondLastScoreUpdateLabel1.text = "+\(player1.historyUndoable[secondLastIndex])"
        } else {
            stackView.scoreInfoView.scoreHistoryView.secondLastScoreUpdateLabel1.text = " "
        }
        if count >= 3 {
            stackView.scoreInfoView.scoreHistoryView.thirdLastScoreUpdateLabel1.text = "+\(player1.historyUndoable[thirdLastIndex])"
        } else {
            stackView.scoreInfoView.scoreHistoryView.thirdLastScoreUpdateLabel1.text = " "
        }
    }
    
    func updateScoreHistoryViewAndUndoButtonsViewOfPlayer2() {
        //undo button:
        if player2.historyUndoable.isEmpty {
            stackView.scoreInfoView.undoButtonsView.undoButton2.isHidden = true
        } else if stackView.scoreInfoView.undoButtonsView.undoButton2.isHidden {
            stackView.scoreInfoView.undoButtonsView.undoButton2.isHidden = false
        }
        //undoable history labels:
        let stack = player2.historyUndoable
        let count = stack.count
        let secondLastIndex = count - 2
        let thirdLastIndex = count - 3
        if let lastScoreUpdate = player2.historyUndoable.last {
            stackView.scoreInfoView.scoreHistoryView.lastScoreUpdateLabel2.text = "+\(lastScoreUpdate)"
        } else {
            stackView.scoreInfoView.scoreHistoryView.lastScoreUpdateLabel2.text = " "
        }
        if count >= 2 {
            stackView.scoreInfoView.scoreHistoryView.secondLastScoreUpdateLabel2.text = "+\(player2.historyUndoable[secondLastIndex])"
        } else {
            stackView.scoreInfoView.scoreHistoryView.secondLastScoreUpdateLabel2.text = " "
        }
        if count >= 3 {
            stackView.scoreInfoView.scoreHistoryView.thirdLastScoreUpdateLabel2.text = "+\(player2.historyUndoable[thirdLastIndex])"
        } else {
            stackView.scoreInfoView.scoreHistoryView.thirdLastScoreUpdateLabel2.text = " "
        }
    }
    
}
