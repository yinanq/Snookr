//
//  ScoreboardVC+ResetDelegates.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/13/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

extension ScoreboardVC: ResetButtonDelegate, ResetAlertVCDelegate, ScoreResetAlertVCDelegate {
    
    func didTapResetButton() {        
        let alertVC = ResetAlertVC(title: "Sure?", body: "Gonna reset the scores. Sure you wanna do it?", cancelBtnTitle: "No", confirmBtnTitile: "Yes", delegate: self)
//        let alertVC = ScoreResetAlertVC(title: "Sure?", body: "Gonna reset the scores. Sure you wanna do it?", cancelBtnTitle: "No", confirmBtnTitile: "Yes", delegate: self, winnerDelegate: self)
        alertVC.modalPresentationStyle = .overCurrentContext
        alertVC.modalTransitionStyle = .crossDissolve
        present(alertVC, animated: false)
        
    }
    
    func didTapAddFrameToggle() {
        print("didTapAddFrameToggle")
    }
    
    func didTapConfirmToReset() {
        resetScores()
        notifCtr.post(name: .scoreboardVCDidResetScores, object: nil)
    }
    
    func resetScores() {
        //update model:
        player1.score = 0
        player2.score = 0
        player1.historyUndoable.removeAll()
        player1.historyRedoable.removeAll()
        player2.historyUndoable.removeAll()
        player2.historyRedoable.removeAll()
        //update (model and) view:
        updateScoresView()
        updateScoreHistoryViewAndUndoButtonsViewFor(&player1)
        updateScoreHistoryViewAndUndoButtonsViewFor(&player2)
        clearRedoHistoryAndButtonFor(&player1)
        clearRedoHistoryAndButtonFor(&player2)
        updateResetButton()
        //persist:
        persistScoreFor(&player1)
        persistScoreFor(&player2)
    }
    
}
