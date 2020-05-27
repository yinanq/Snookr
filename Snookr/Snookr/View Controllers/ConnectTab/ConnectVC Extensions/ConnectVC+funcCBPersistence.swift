//
//  ConnectVC+funcCBPersistence.swift
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
    
    func cbPersistOpponentScore(to receivedValue: Int) {
        var key: String!
        switch opponentIs {
        case .player1: key = SNKCommonKey.player1sScore
        case .player2: key = SNKCommonKey.player2sScore
        }
        if let key = key { defaults.set(receivedValue, forKey: key) }
    }
    
    func cbPersistResetFrames() {
        defaults.set(0, forKey: SNKCommonKey.player1sFrame)
        defaults.set(0, forKey: SNKCommonKey.player2sFrame)
    }
    
    func cbPersistResetScroes() {
        defaults.set(0, forKey: SNKCommonKey.player1sScore)
        defaults.set(0, forKey: SNKCommonKey.player2sScore)
    }
    
}
