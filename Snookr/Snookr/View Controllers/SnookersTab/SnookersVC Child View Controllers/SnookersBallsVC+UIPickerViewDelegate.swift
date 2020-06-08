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
            if view.frame.size.height < 1 {
                view.frame.size.height = SNKPadding.separatorViewWidth
                view.frame.size.width -= 2*SNKPadding.small
                view.frame.origin.x += SNKPadding.small
                view.layer.cornerRadius = view.frame.size.height/2
//                view.backgroundColor = UIColor(red: 49/255, green: 49/255, blue: 54/255, alpha: 1)//segmented control bg apple-alt
//                view.backgroundColor = UIColor(red: 120/255, green: 120/255, blue: 123/255, alpha: 1)//SNKColor.foregroundGray apple-alt
                view.backgroundColor = SNKColor.foregroundWhite
            }
        }
        var label: SNKLabel!
        if row == 0 {
            label = SNKLabel(color: SNKColor.foregroundWhite, fontSize: SNKFontSize.regular, fontWeight: SNKFontWeight.forFontSizeRegular)
        } else {
            label = SNKLabel(color: SNKColor.foreground, fontSize: SNKFontSize.regular, fontWeight: SNKFontWeight.forFontSizeRegular)
        }
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
