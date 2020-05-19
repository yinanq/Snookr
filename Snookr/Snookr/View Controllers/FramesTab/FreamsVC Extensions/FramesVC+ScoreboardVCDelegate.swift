//
//  FramesVC+ScoreboardVCDelegate.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/19/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

extension FramesVC: ScoreboardVCDelegate {
    
    func scoreboardVCDidChangePlayer1NameTo(_ newName: String) {
        player1.name = newName //no need to persist becuase it was just already done by delegate owner
        playerNamesView.textView1.text = newName
    }
    
    func scoreboardVCDidChangePlayer2NameTo(_ newName: String) {
        player2.name = newName
        playerNamesView.textView2.text = newName
    }

}
