//
//  FramesVC+funcViewUpdaters.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/18/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

//func view updaters:
extension FramesVC {
    
    func updateFramesWonView() {
        framesWonView.framesWonLabel1.text = String(player1.framesWon)
        framesWonView.framesWonLabel2.text = String(player2.framesWon)
    }
    
    func updateFramesWonViewFor(_ player: inout Player) {
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
