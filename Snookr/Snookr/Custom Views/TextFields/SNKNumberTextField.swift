//
//  SNKNumberTextField.swift
//  Snookr
//
//  Created by Yinan Qiu on 6/2/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class SNKNumberTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(paste(_:)) {
            return false
        } else {
            return super.canPerformAction(action, withSender: sender)
        }
    }
    
    private func configure() {
        keyboardType = .numberPad
        layer.cornerRadius = SNKCornerRadius.big
        layer.borderWidth = SNKBorderWidth.regular
        layer.borderColor = SNKColor.foreground.cgColor
        textAlignment = .center
        textColor = SNKColor.foreground
        tintColor = SNKColor.foreground
        font = UIFont.systemFont(ofSize: SNKFontSize.huge, weight: SNKFontWeight.forFontSizeHuge)
        attributedPlaceholder = NSAttributedString(string: "000", attributes: [NSAttributedString.Key.foregroundColor: SNKColor.backgroundSecondary])
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 195),
            heightAnchor.constraint(equalToConstant: 90)
        ])
    }
        
    func disable() {
        isEnabled = false
        layer.borderColor = SNKColor.backgroundSecondary.cgColor
    }
    
    func enable() {
        isEnabled = true
        layer.borderColor = SNKColor.foreground.cgColor
    }

}
