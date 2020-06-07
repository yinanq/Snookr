//
//  FramesVC+funcModelUpdaters.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/21/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

extension FramesVC {
    
    func updatePlayerNameModel(player: inout Player, newName: String) { player.name = newName }
    
    func updateFramesWonModel(of player: inout Player, to newValue: Int) { player.framesWon = newValue }
    
}
