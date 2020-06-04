//
//  Snookers+SnookersDifVCDelegate.swift
//  Snookr
//
//  Created by Yinan Qiu on 6/3/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

extension SnookersVC: SnookersDifVCTextFieldDelegate {
    
    func snookersDifVCsnkNumberTextFieldDidBeginEditing() {
        dim()
        view.addGestureRecognizer(tapRecognizer)
        tapRecognizer.addTarget(view!, action: #selector(view.endEditing))
    }
    
    func snookersDifVCsnkTextFieldDidEndEditing() {
        undim()
        view.removeGestureRecognizer(tapRecognizer)
    }
    
    private func dim() {
        [titleVC.view, ballsVC.view].forEach { view in
            view?.isUserInteractionEnabled = false
            UIView.animate(withDuration: SNKAnimationDuration.short) { view?.alpha = SNKAlpha.dimTo.rawValue }
        }
    }
    
    private func undim() {
        [titleVC.view, ballsVC.view].forEach { view in
            view?.isUserInteractionEnabled = true
            UIView.animate(withDuration: SNKAnimationDuration.short) { view?.alpha = 1 }
        }
    }
    
}
