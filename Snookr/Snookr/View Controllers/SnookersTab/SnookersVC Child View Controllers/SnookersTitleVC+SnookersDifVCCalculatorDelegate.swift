//
//  SnookersTitleVC+SnookersDifVCCalculatorDelegate.swift
//  Snookr
//
//  Created by Yinan Qiu on 6/3/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

extension SnookersTitleVC: SnookersDifVCCalculatorDelegate {
    
    func snookersDifVCDidChangeDif(to newDif: Int) {
        scoreDif = newDif
        guard let ballsTotalPoints = ballsTotalPoints else { return }
        updateNumberOfSnookersRequired(scoreDif: scoreDif, ballsTotalPoints: ballsTotalPoints)
    }
    
}
