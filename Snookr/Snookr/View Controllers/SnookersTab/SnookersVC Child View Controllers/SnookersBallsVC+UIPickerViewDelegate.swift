//
//  SnookersBallsVC+UIPickerViewDelegate.swift
//  Snookr
//
//  Created by Yinan Qiu on 6/3/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

extension SnookersBallsVC: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: ballsPickerOptionStrings[row], attributes: [NSAttributedString.Key.foregroundColor: SNKColor.foreground])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            delegate.snookersBallsVCPickerDidUnselect()
        } else {
            delegate.snookersBallsVCPickerDidSelect(ballsTotalPoints: ballsTotalPoints[row-1])
        }
    }
    
}
