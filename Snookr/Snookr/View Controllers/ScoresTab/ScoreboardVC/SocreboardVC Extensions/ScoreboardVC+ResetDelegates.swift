//
//  ScoreboardVC+ResetDelegates.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/13/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

extension ScoreboardVC: ResetButtonDelegate, ResetConfirmViewDelegate {
    
    func didTapResetButton() {
        //used view, not vc, becuase vc's modalTransitionStyle crossDissolve disables button interactivity during too long (and cannot be shorterned) transition animation:
        let resetConfirmView = ResetConfirmView(delegate: self)
        view.addSubview(resetConfirmView)
        NSLayoutConstraint.activate([
            resetConfirmView.topAnchor.constraint(equalTo: view.topAnchor),
            resetConfirmView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            resetConfirmView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            resetConfirmView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    func didTapConfirmResetButton() {
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
        playFrameStarterAnimation()
        //persist:
        persistScoreFor(&player1)
        persistScoreFor(&player2)
    }
    
}
