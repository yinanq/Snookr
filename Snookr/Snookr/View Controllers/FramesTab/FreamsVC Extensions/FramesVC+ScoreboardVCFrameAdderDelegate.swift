//
//  FramesVC+ScoreboardVCFrameAdderDelegate.swift
//  Snookr
//
//  Created by Yinan Qiu on 6/6/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

extension FramesVC: ScoreboardVCFrameAdderDelegate {
    func scoreboardVCDidRequestAddingFrameFor(_ winner: Player) {
        switch winner.playerId {
        case .player1: addOneFrameFor(&player1)
        case .player2: addOneFrameFor(&player2)
        case .unassigned: print("error: .unassigned playerId in scoreboardVCDidRequestAddingFrameFor")
        }
        updateResetButton()
    }
}
