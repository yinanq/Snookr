//
//  SnookersBallsVC+UIPickerViewDelegate.swift
//  Snookr
//
//  Created by Yinan Qiu on 6/3/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

extension SnookersBallsVC: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        for view in pickerView.subviews {
            if view.frame.size.height < 2 {
                view.frame.size.height = 2
                view.backgroundColor = UIColor(red: 49/255, green: 49/255, blue: 54/255, alpha: 1)
            }
        }
        var color = SNKColor.foreground
//        switch row {
//        case 0: color = SNKColor.foregroundGray
//        case 1: color = SNKColor.ballPink
//        case 2: color = SNKColor.ballBlue
//        case 3: color = SNKColor.ballBrown
//        case 4: color = SNKColor.ballGreen
//        case 5: color = SNKColor.ballYellow
//        case 6, 7, 8, 9, 10: color = SNKColor.ballRed
//        default: print("extra row in picker for Colors Remaining")
//        }
        if row == 0 { color = SNKColor.foregroundGray }
        let label = SNKLabel(color: color, fontSize: SNKFontSize.regular, fontWeight: SNKFontWeight.forFontSizeRegular)
        label.translatesAutoresizingMaskIntoConstraints = true
        label.text = ballsPickerOptionStrings[row]
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            delegate.snookersBallsVCPickerDidUnselect()
        } else {
            delegate.snookersBallsVCPickerDidSelect(ballsTotalPoints: ballsTotalPoints[row-1])
        }
    }
    
}
