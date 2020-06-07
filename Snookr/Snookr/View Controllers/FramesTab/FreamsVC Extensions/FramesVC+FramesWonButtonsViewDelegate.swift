//
//  FramesVC+FramesWonButtonsViewDelegate.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/18/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

extension FramesVC: FramesWonButtonsViewDelegate {
    
    func didTapFramesWonButton(withTag: Int) {
        switch withTag {
        case 1: addOneFrameFor(&player1)
        case 2: addOneFrameFor(&player2)
        case -1: subtractOneFrameFor(&player1)
        case -2: subtractOneFrameFor(&player2)
        default: print("error: invalid tag, in didTapFramesWonButton")
        }
        updateResetButton()
    }
    
    func addOneFrameFor(_ player: inout Player) {
        player.framesWon += 1
        updateFramesWonView(of: &player)
        persistFramesWon(of: &player)
        notifCtr.post(name: .framesVCChangedFramesOfEitherPlayer, object: player.framesWon)
    }
    
    private func subtractOneFrameFor(_ player: inout Player) {
        guard player.framesWon > 0 else { return }
        player.framesWon -= 1
        updateFramesWonView(of: &player)
        persistFramesWon(of: &player)
        notifCtr.post(name: .framesVCChangedFramesOfEitherPlayer, object: player.framesWon)
    }
    
}
