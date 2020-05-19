//
//  FramesVC+ResetDelegates.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/18/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

extension FramesVC: FramesResetButtonDelegate, SNKAlertVCDelegate {
    
    func didTapFramesResetButton() {
        let resetConfirmVC = SNKAlertVC(title: "Sure?", body: "Gonna reset the frames. Sure you wanna do it?", cancelBtnTitle: "No", confirmBtnTitile: "Yes", delegate: self)
        resetConfirmVC.modalPresentationStyle = .overCurrentContext
        resetConfirmVC.modalTransitionStyle = .crossDissolve
        present(resetConfirmVC, animated: true)
    }
    
    func didTapConfirmButtonForReset() {
        UIView.animate(withDuration: SNKAnimationDuration.short, delay: 0, options: .curveEaseOut, animations: {
            self.view.alpha = 0
        }) { _ in
            self.resetFramesWon()
            UIView.animate(withDuration: SNKAnimationDuration.medium, delay: 0, options: .curveEaseIn, animations: {
                self.view.alpha = 1
            }, completion: nil)
        }
    }

    private func resetFramesWon() {
        //update model:
        player1.framesWon = 0
        player2.framesWon = 0
        //update (model and) view:
        updateFramesWonView()
        updateResetButton()
        //persist:
        persistFramesWonFor(&player1)
        persistFramesWonFor(&player2)
    }
    
}
