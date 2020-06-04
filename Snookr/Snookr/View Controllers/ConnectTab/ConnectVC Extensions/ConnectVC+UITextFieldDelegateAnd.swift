//
//  ConnectVC+UITextFieldDelegateAnd.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/27/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

extension ConnectVC: SNKNumberTextFieldDelegate {    
    func snkNumberTextFieldEditingChanged(textField: SNKNumberTextField) {
        if let count = textField.text?.count {
            if count == 3 {
                connectButton.enableSolidStyleButton()
                cbUserDefinedLocalName = connectCodeTextField.text
            } else {
                connectButton.disableSolidStyleButton()
            }
        }
    }
}

extension ConnectVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        dim()
        view.addGestureRecognizer(tapRecognizer)
        tapRecognizer.addTarget(view!, action: #selector(view.endEditing))
        connectInstructionTextView.unhide()
        textField.text?.removeAll()
        connectButton.disableSolidStyleButton()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        undim()
        view.removeGestureRecognizer(tapRecognizer)
        connectInstructionTextView.hide()
        connectButton.enableSolidStyleButton()
        if textField.text?.count ?? 0 < SNKUserInputLimit.connectCodeLengthLimit { textField.text?.removeAll() }
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
    
    private func dim() {
        [separatorView, playerNamesView, meWhichPlayerView, connectedTextView].forEach { view in
            view.isUserInteractionEnabled = false
            UIView.animate(withDuration: SNKAnimationDuration.short) { view.alpha = SNKAlpha.dimTo.rawValue }
        }
    }
    
    private func undim() {
        [separatorView, playerNamesView, meWhichPlayerView, connectedTextView].forEach { view in
            view.isUserInteractionEnabled = true
            UIView.animate(withDuration: SNKAnimationDuration.short) { view.alpha = 1 }
        }
    }
    
}
