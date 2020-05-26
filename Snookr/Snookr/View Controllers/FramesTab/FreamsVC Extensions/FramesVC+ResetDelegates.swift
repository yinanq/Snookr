//
//  FramesVC+ResetDelegates.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/18/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

extension FramesVC: FramesResetButtonDelegate, ResetAlertVCDelegate {
    
    func didTapFramesResetButton() {
        let resetAlertVC = ResetAlertVC(title: "Sure?", body: "Gonna reset the frames. Sure you wanna do it?", cancelBtnTitle: "No", confirmBtnTitile: "Yes", delegate: self)
        resetAlertVC.modalPresentationStyle = .overCurrentContext
        resetAlertVC.modalTransitionStyle = .crossDissolve
        present(resetAlertVC, animated: true)
    }
    
    func didTapConfirmToReset() {
        UIView.animate(withDuration: SNKAnimationDuration.short, delay: 0, options: .curveEaseOut, animations: {
            self.view.alpha = 0
        }) { _ in
            self.resetFramesWonAndNotify()
            UIView.animate(withDuration: SNKAnimationDuration.medium, delay: 0, options: .curveEaseIn, animations: {
                self.view.alpha = 1
            }, completion: nil)
        }
    }
    
    private func resetFramesWonAndNotify() {
        resetFramesWon()
        notifCtr.post(name: .framesVCDidResetFrames, object: nil)
    }

    func resetFramesWon() {
        //update model:
        player1.framesWon = 0
        player2.framesWon = 0
        //update (model and) view:
        updateFramesWonView()
        updateResetButton()
        //persist:
        persistFramesWon(of: &player1)
        persistFramesWon(of: &player2)
    }
    
}
