//
//  FramesVC+funcViewUpdaters.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/18/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

extension FramesVC {
    
    func updateViewsBasedOnCBState() {
        switch cbState {
        case .notConnected: unlockOpponentInfoAfterCB()
        case .isConnected: lockOpponentInfoDuringCB()
        case .isConnecting: lockOpponentInfoDuringCB()
        }
    }
    private func lockOpponentInfoDuringCB() {
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
    private func unlockOpponentInfoAfterCB() {
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
    
    func updatePlayerNameView(for player: Player) {
        switch player.playerId {
        case .player1: playerNamesView.textView1.text = player.name
        case .player2: playerNamesView.textView2.text = player.name
        case .unassigned: print("error: in updatePlayerNameView")
        }
    }
    
    func updateFramesWonView() {
        framesWonView.framesWonLabel1.text = String(player1.framesWon)
        framesWonView.framesWonLabel2.text = String(player2.framesWon)
    }
    
    func updateFramesWonView(of player: inout Player) {
        switch player.playerId {
        case .player1: framesWonView.framesWonLabel1.text = String(player.framesWon)
        case .player2: framesWonView.framesWonLabel2.text = String(player.framesWon)
        case .unassigned: print("error: .unassigned playerId, in updateFramesWonViewFor")
        }
    }
    
    func updateResetButton() {
        if player1.framesWon == 0 && player2.framesWon == 0 {
            if resetButton.isEnabled || resetButton.alpha != SNKAlpha.disabledButton.rawValue { resetButton.disableOutlineStyleButton() }
        } else {
            if !resetButton.isEnabled || resetButton.alpha != 1 { resetButton.enableOutlineStyleButton() }
        }
    }
    
}
