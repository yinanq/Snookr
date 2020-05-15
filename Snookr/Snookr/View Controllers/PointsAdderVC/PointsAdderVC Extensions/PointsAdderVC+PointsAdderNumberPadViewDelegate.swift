//
//  PointsAdderVC+.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/14/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

extension PointsAdderVC: PointsAdderNumberPadViewDelegate {
    func didTapNumberPad(buttonTag: Int) {
        
        switch buttonTag {
            
        case 1, 2, 3, 4, 5, 6, 7, 8, 9, 0:
            if buttonTag == 0 && pointsString.isEmpty { return }
            if pointsString.count >= 3 { return }
            pointsString += String(buttonTag)
            if numberPadView.keyDelete.isHidden {
                numberPadView.keyDelete.isHidden = false
            }
            
        case -1:
            pointsString.removeLast()
            if pointsString.isEmpty { numberPadView.keyDelete.isHidden = true }
            
        default: print("error: invalid buttonTag in didTapNumberPad")
        }
        
        pointsLabel.text = pointsString
        if let pointsStringDisplayed = pointsLabel.text {
            points = Int(pointsStringDisplayed)
        }
    }
}
