//
//  ConnectCodeTextField.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/27/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

protocol ConnectCodeTextFieldDelegate: class {
    func connectCodeTextFieldEditingChanged(textField: ConnectCodeTextField)
}

class ConnectCodeTextField: UITextField {
    
    weak var snkDelegate: ConnectCodeTextFieldDelegate!
    
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
        layer.borderWidth = 2
        layer.borderColor = SNKColor.foreground.cgColor
        textAlignment = .center
        textColor = SNKColor.foreground
        tintColor = SNKColor.foreground
        font = UIFont.systemFont(ofSize: SNKFontSize.huge, weight: .thin)
        attributedPlaceholder = NSAttributedString(string: "000", attributes: [NSAttributedString.Key.foregroundColor: SNKColor.backgroundSecondary])
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 200),
            heightAnchor.constraint(equalToConstant: 90)
        ])
        addTarget(self, action: #selector(connectCodeTextFieldEditingChanged), for: .editingChanged)
    }
    
    @objc func connectCodeTextFieldEditingChanged(sender: ConnectCodeTextField) { snkDelegate.connectCodeTextFieldEditingChanged(textField: sender) }
    
    func disable() {
        isEnabled = false
        layer.borderColor = SNKColor.backgroundSecondary.cgColor
    }
    
    func enable() {
        isEnabled = true
        layer.borderColor = SNKColor.foreground.cgColor
    }
    
}
