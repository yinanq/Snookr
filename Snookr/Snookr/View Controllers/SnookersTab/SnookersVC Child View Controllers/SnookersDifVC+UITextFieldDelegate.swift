//
//  SnookersDifVC+UITextFieldDelegate.swift
//  Snookr
//
//  Created by Yinan Qiu on 6/3/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

extension SnookersDifVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text?.removeAll()
        textFieldDelegate.snookersDifVCsnkNumberTextFieldDidBeginEditing()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        var number = 0
        if let string = textField.text {
            number = Int(string) ?? 0
        }
        userInputDif = number
        textField.text = String(number)
        textFieldDelegate.snookersDifVCsnkTextFieldDidEndEditing()
        calculatorDelegate.snookersDifVCDidChangeDif(to: number)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let limit = SNKUserInputLimit.connectCodeLengthLimit
        if textField.text != nil {
            let string = (textField.text! + string)
            if string.count <= limit {
                return true
            } else {
                textField.text = String(string[..<string.index(string.startIndex, offsetBy: limit)])
                return false
            }
        } else {
            return true
        }
    }
    
}
