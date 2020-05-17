//
//  ScoreboardVC+PairingDelegate.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/17/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

extension ScoreboardVC: PairButtonDelegate, PairedStatusViewDelegate {
    
    func didTapPairButton() {
        pairButton.isHidden = true
        paireredStatusView.isHidden = false
    }
    
    func didTapPairedStatusView() {
        paireredStatusView.isHidden = true
        pairButton.isHidden = false
    }
    
}
