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
        if player1.lastScoreUpdate == nil && player1.secondLastScoreUpdate == nil && player1.thirdLastScoreUpdate == nil {
            stackView.scoreInfoView.undoButtonsView.undoButton1.isHidden = true
        } else if stackView.scoreInfoView.undoButtonsView.undoButton1.isHidden == true {
            stackView.scoreInfoView.undoButtonsView.undoButton1.isHidden = false
        }
        if let lastScoreUpdate = player1.lastScoreUpdate {
            stackView.scoreInfoView.scoreHistoryView.lastScoreUpdateLabel1.text = "+\(lastScoreUpdate)"
        } else {
            stackView.scoreInfoView.scoreHistoryView.lastScoreUpdateLabel1.text = " "
        }
        if let secondLastScoreUpdate = player1.secondLastScoreUpdate {
            stackView.scoreInfoView.scoreHistoryView.secondLastScoreUpdateLabel1.text = "+\(secondLastScoreUpdate)"
        } else {
            stackView.scoreInfoView.scoreHistoryView.secondLastScoreUpdateLabel1.text = " "
        }
        if let thirdLastScoreUpdate = player1.thirdLastScoreUpdate {
            stackView.scoreInfoView.scoreHistoryView.thirdLastScoreUpdateLabel1.text = "+\(thirdLastScoreUpdate)"
        } else {
            stackView.scoreInfoView.scoreHistoryView.thirdLastScoreUpdateLabel1.text = " "
        }
    }
    
    func updateScoreHistoryViewAndUndoButtonsViewOfPlayer2() {
        if player2.lastScoreUpdate == nil && player2.secondLastScoreUpdate == nil && player2.thirdLastScoreUpdate == nil {
            stackView.scoreInfoView.undoButtonsView.undoButton2.isHidden = true
        } else if stackView.scoreInfoView.undoButtonsView.undoButton2.isHidden == true {
            stackView.scoreInfoView.undoButtonsView.undoButton2.isHidden = false
        }
        if let lastScoreUpdate = player2.lastScoreUpdate {
            stackView.scoreInfoView.scoreHistoryView.lastScoreUpdateLabel2.text = "+\(lastScoreUpdate)"
        } else {
            stackView.scoreInfoView.scoreHistoryView.lastScoreUpdateLabel2.text = " "
        }
        if let secondLastScoreUpdate = player2.secondLastScoreUpdate {
            stackView.scoreInfoView.scoreHistoryView.secondLastScoreUpdateLabel2.text = "+\(secondLastScoreUpdate)"
        } else {
            stackView.scoreInfoView.scoreHistoryView.secondLastScoreUpdateLabel2.text = " "
        }
        if let thirdLastScoreUpdate = player2.thirdLastScoreUpdate {
            stackView.scoreInfoView.scoreHistoryView.thirdLastScoreUpdateLabel2.text = "+\(thirdLastScoreUpdate)"
        } else {
            stackView.scoreInfoView.scoreHistoryView.thirdLastScoreUpdateLabel2.text = " "
        }
    }
    
}
