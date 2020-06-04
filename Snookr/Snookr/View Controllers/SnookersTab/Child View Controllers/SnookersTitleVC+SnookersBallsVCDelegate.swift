//
//  SnookersTitleVC+SnookersBallsVCDelegate.swift
//  Snookr
//
//  Created by Yinan Qiu on 6/3/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

extension SnookersTitleVC: SnookersBallsVCDelegate {
    
    func snookersBallsVCPickerDidSelect(ballsTotalPoints: Int) {
        self.ballsTotalPoints = ballsTotalPoints
        updateNumberOfSnookersRequired(scoreDif: self.scoreDif, ballsTotalPoints: ballsTotalPoints)
    }
    
    func snookersBallsVCPickerDidUnselect() {
        resetNumberOfSnookersRequired()
    }
    
}
