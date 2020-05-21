//
//  ScoreboardVC+ResetDelegates.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/13/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

extension ScoreboardVC: ResetButtonDelegate, ResetAlertVCDelegate {
    
    func didTapResetButton() {        
        let resetAlertVC = ResetAlertVC(title: "Sure?", body: "Gonna reset the scores. Sure you wanna do it?", cancelBtnTitle: "No", confirmBtnTitile: "Yes", delegate: self)
        resetAlertVC.modalPresentationStyle = .overCurrentContext
        resetAlertVC.modalTransitionStyle = .crossDissolve
        present(resetAlertVC, animated: true)
    }
    
    func didTapConfirmToReset() {
        UIView.animate(withDuration: SNKAnimationDuration.short, delay: 0, options: .curveEaseOut, animations: {
            self.view.alpha = 0
        }) { _ in
            self.resetScores()
            UIView.animate(withDuration: SNKAnimationDuration.medium, delay: 0, options: .curveEaseIn, animations: {
                self.view.alpha = 1
            }, completion: nil)
        }
    }
    
    private func resetScores() {
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
