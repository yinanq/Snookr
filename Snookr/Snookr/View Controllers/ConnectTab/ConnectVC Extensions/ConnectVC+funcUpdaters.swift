//
//  ConnectVC+funcUpdaters.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/25/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

extension ConnectVC {
    
    func cbUpdateName(of player: inout Player, to newName: String) {
        updatePlayerNameModel(player: &player, newName: newName)
        updatePlayerNameView(for: player)
        switch player.playerId {
        case .player1:
            notifCtr.post(name: .connectVCChangedNameOfPlayer1, object: player.name)
            defaults.set(player.name, forKey: Key.player1sName)
        case .player2:
            notifCtr.post(name: .connectVCChangedNameOfPlayer2, object: player.name)
            defaults.set(player.name, forKey: Key.player2sName)
        case .unassigned: print("error: .unassigned playerId in cbUpdateName")
        }
    }
    
}
