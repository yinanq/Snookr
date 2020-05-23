//
//  ConnectVC+funcModelUpdaters.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/21/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import MultipeerConnectivity

extension ConnectVC {
    
    func updatePlayerNameModel(player: inout Player, newName: String) { player.name = newName }
    
}
