//
//  FramesVC+CB.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/26/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

extension FramesVC {
    
    func cbUpdateForState() {
        switch cbState {
        case .notConnected: cbUnlockOpponentInfoAfterCB()
        case .isConnected, .isConnecting:
            cbLockOpponentInfoDuringCB()
            cbUpdateOpponentStartingFrame()
        }
    }
    
    private func cbUpdateOpponentStartingFrame() {
        switch opponentIs {
        case .player1:
            player1.framesWon = defaults.integer(forKey: SNKCommonKey.player1sFrame)
            updateFramesWonView(of: &player1)
        case .player2:
            player2.framesWon = defaults.integer(forKey: SNKCommonKey.player2sFrame)
            updateFramesWonView(of: &player2)
        }
    }
    
    private func cbLockOpponentInfoDuringCB() {
        switch opponentIs {
        case .player1:
            self.playerNamesView.textView1.isEditable = false
            self.framesWonButtonsView.minusOneButton1.alpha = 0
            self.framesWonButtonsView.plusOneButton1.alpha = 0
        case .player2:
            self.playerNamesView.textView2.isEditable = false
            self.framesWonButtonsView.minusOneButton2.alpha = 0
            self.framesWonButtonsView.plusOneButton2.alpha = 0
        }
    }
    
    private func cbUnlockOpponentInfoAfterCB() {
        switch opponentIs {
        case .player1:
            self.playerNamesView.textView1.isEditable = true
            self.framesWonButtonsView.minusOneButton1.alpha = 1
            self.framesWonButtonsView.plusOneButton1.alpha = 1
        case .player2:
            self.playerNamesView.textView2.isEditable = true
            self.framesWonButtonsView.minusOneButton2.alpha = 1
            self.framesWonButtonsView.plusOneButton2.alpha = 1
        }
    }
    
}
