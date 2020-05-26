//
//  ConnectVC+funcViewUpdaters.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/21/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

extension ConnectVC {
    
    func updatePlayerNameView(for player: Player) {
        switch player.playerId {
        case .player1: playerNamesView.textView1.text = player.name
        case .player2: playerNamesView.textView2.text = player.name
        case .unassigned: print("error: .unassigned playerId, in updatePlayerNameView")
        }
    }
    
}
