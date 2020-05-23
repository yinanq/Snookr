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
    
    func mcGeneratePeerID() {
        //to add guard when moved from testPeerIDUserCode to textField to be build
        mcPeerIDDisplayName = testPeerIDUserCode
        mcPeerID = MCPeerID(displayName: mcPeerIDDisplayName!)
        //to add persistence
    }
    
}
