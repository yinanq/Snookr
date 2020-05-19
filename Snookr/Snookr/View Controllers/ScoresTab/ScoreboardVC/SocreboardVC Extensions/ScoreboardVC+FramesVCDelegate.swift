//
//  ScoreboardVC+FramesVCDelegate.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/19/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

extension ScoreboardVC: FramesVCDelegate {
    
    func framesVCDidChangePlayer1NameTo(_ newName: String) {
        player1.name = newName //no need to persist becuase it was just already done by delegate owner
        stackView.scoreInfoView.playerNamesView.textView1.text = newName
    }
    
    func framesVCDidChangePlayer2NameTo(_ newName: String) {
        player2.name = newName
        stackView.scoreInfoView.playerNamesView.textView2.text = newName
    }
    
}
