//
//  ConnectVC+funcUpdaters.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/25/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

extension ConnectVC {
    
    func cbUpdateOpponentName(to receivedName: String) {
        switch opponentIs {
        case .player1:
            updatePlayerNameModel(player: &player1, newName: receivedName)
            updatePlayerNameView(for: player1)
            notifCtr.post(name: .connectVCChangedNameOfPlayer1, object: receivedName)
            defaults.set(player1.name, forKey: SNKCommonKey.player1sName)
        case .player2:
            updatePlayerNameModel(player: &player2, newName: receivedName)
            updatePlayerNameView(for: player2)
            notifCtr.post(name: .connectVCChangedNameOfPlayer2, object: receivedName)
            defaults.set(player2.name, forKey: SNKCommonKey.player2sName)
        }
    }
    
}
