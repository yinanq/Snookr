//
//  ConnectVC+funcPersistence.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/26/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

extension ConnectVC {
    
    func cbPersistOpponentFrame(to receivedValue: Int) {
        var key: String!
        switch opponentIs {
        case .player1: key = SNKCommonKey.player1sFrame
        case .player2: key = SNKCommonKey.player2sFrame
        }
        if let key = key { defaults.set(receivedValue, forKey: key) }
    }
    
}
