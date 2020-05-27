//
//  ScoreboardVC+funcCoders.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/26/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import Foundation

extension ScoreboardVC {
    
    func cbNotifyData(of player: Player) {
        var h1: Int?
        var h2: Int?
        var h3: Int?
        let hist = player.historyUndoable
        if !hist.isEmpty {
            h1 = hist.last
            let count = hist.count
            if count >= 2 {
                h2 = hist[count-2]
            }
            if count >= 3 {
                h3 = hist[count-3]
            }
        }
        let data = SNKcbData(snkCBDataType: SNKcbDataType.socre, score: player.score, scoreHist1: h1, scoreHist2: h2, scoreHist3: h3)
        notifCtr.post(name: .scoreboardVCChangedScoreOfEitherPlayer, object: data)
    }
    
    func cbUpdateOpponentScoreToReceived(_ data: SNKcbData) {
        switch opponentIs {
        case .player1:
            if let score = data.score { player1.score = score }
            persistScoreFor(&player1)
            if let sH = data.scoreHist1 {
                stackView.scoreInfoView.scoreHistoryView.lastScoreUpdateLabel1.text = "+\(sH)"
            } else {
                stackView.scoreInfoView.scoreHistoryView.lastScoreUpdateLabel1.text = " "
            }
            if let sH = data.scoreHist2 {
                stackView.scoreInfoView.scoreHistoryView.secondLastScoreUpdateLabel1.text = "+\(sH)"
            } else {
                stackView.scoreInfoView.scoreHistoryView.secondLastScoreUpdateLabel1.text = " "
            }
            if let sH = data.scoreHist3 {
                stackView.scoreInfoView.scoreHistoryView.thirdLastScoreUpdateLabel1.text = "+\(sH)"
            } else {
                stackView.scoreInfoView.scoreHistoryView.thirdLastScoreUpdateLabel1.text = " "
            }
        case .player2:
            if let score = data.score { player2.score = score }
            persistScoreFor(&player2)
            if let sH = data.scoreHist1 {
                stackView.scoreInfoView.scoreHistoryView.lastScoreUpdateLabel2.text = "+\(sH)"
            } else {
                stackView.scoreInfoView.scoreHistoryView.lastScoreUpdateLabel2.text = " "
            }
            if let sH = data.scoreHist2 {
                stackView.scoreInfoView.scoreHistoryView.secondLastScoreUpdateLabel2.text = "+\(sH)"
            } else {
                stackView.scoreInfoView.scoreHistoryView.secondLastScoreUpdateLabel2.text = " "
            }
            if let sH = data.scoreHist3 {
                stackView.scoreInfoView.scoreHistoryView.thirdLastScoreUpdateLabel2.text = "+\(sH)"
            } else {
                stackView.scoreInfoView.scoreHistoryView.thirdLastScoreUpdateLabel2.text = " "
            }
        }
        updateScoresView()
    }
    
    func cbUpdateForState() {
        switch cbState {
        case .notConnected:
            cbUnlockOpponentInfoAfterCB()
            cbClearOpponentUndoHistory()
        case .isConnected, .isConnecting:
            cbLockOpponentInfoDuringCB()
            cbClearOpponentUndoHistory()
            cbUpdateOpponentStartingScore()
        }
    }
    
    private func cbUpdateOpponentStartingScore() {
        switch opponentIs {
        case .player1:
            player1.score = defaults.integer(forKey: SNKCommonKey.player1sScore)
        case .player2:
            player2.score = defaults.integer(forKey: SNKCommonKey.player2sScore)
        }
        updateScoresView()
    }
    
    private func cbClearOpponentUndoHistory() {
        switch opponentIs {
        case .player1:
            player1.historyUndoable.removeAll()
            player1.historyRedoable.removeAll()
            updateScoreHistoryViewAndUndoButtonsViewFor(&player1)
        case .player2:
            player2.historyUndoable.removeAll()
            player2.historyRedoable.removeAll()
            updateScoreHistoryViewAndUndoButtonsViewFor(&player2)
        }
    }
    
    private func cbLockOpponentInfoDuringCB() {
        switch opponentIs {
        case .player1:
            self.stackView.scoreInfoView.playerNamesView.textView1.isEditable = false
            self.stackView.scoreInfoView.undoButtonsView.undoButton1.alpha = 0
            self.stackView.scoreInfoView.undoButtonsView.redoButton1.alpha = 0
            self.stackView.scoreButtonsView.plusButton1.alpha = 0
            self.stackView.scoreButtonsView.plusOneButton1.alpha = 0
        case .player2:
            self.stackView.scoreInfoView.playerNamesView.textView2.isEditable = false
            self.stackView.scoreInfoView.undoButtonsView.undoButton2.alpha = 0
            self.stackView.scoreInfoView.undoButtonsView.redoButton2.alpha = 0
            self.stackView.scoreButtonsView.plusButton2.alpha = 0
            self.stackView.scoreButtonsView.plusOneButton2.alpha = 0
        }

    }
    private func cbUnlockOpponentInfoAfterCB() {
        switch opponentIs {
        case .player1:
            self.stackView.scoreInfoView.playerNamesView.textView1.isEditable = true
            self.stackView.scoreInfoView.undoButtonsView.undoButton1.alpha = 1
            self.stackView.scoreInfoView.undoButtonsView.redoButton1.alpha = 1
            self.stackView.scoreButtonsView.plusButton1.alpha = 1
            self.stackView.scoreButtonsView.plusOneButton1.alpha = 1
        case .player2:
            self.stackView.scoreInfoView.playerNamesView.textView2.isEditable = true
            self.stackView.scoreInfoView.undoButtonsView.undoButton2.alpha = 1
            self.stackView.scoreInfoView.undoButtonsView.redoButton2.alpha = 1
            self.stackView.scoreButtonsView.plusButton2.alpha = 1
            self.stackView.scoreButtonsView.plusOneButton2.alpha = 1
        }
    }
    
}
