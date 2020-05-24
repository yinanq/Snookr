//
//  ConnectVC+MeWhichPlayerViewDelegate.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/23/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

extension ConnectVC: MeWhichPlayerViewDelegate {
    func didTapToggleButton() {
        switch opponentIs {
        case .player1:
            meWhichPlayerView.setOpponentToPlayer2()
            opponentIs = .player2
        case .player2:
            meWhichPlayerView.setOpponentToPlayer1()
            opponentIs = .player1
        }
        defaults.set(opponentIs.rawValue, forKey: SNKCommonKey.opponentIsRawValue)
        notifCtr.post(name: .connectVCChangedWhoswho, object: opponentIs)
    }
}
