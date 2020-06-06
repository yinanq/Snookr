//
//  SNKNumberTextField.swift
//  Snookr
//
//  Created by Yinan Qiu on 6/2/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

protocol SNKNumberTextFieldDelegate: class {
    func snkNumberTextFieldEditingChanged(textField: SNKNumberTextField)
}

class SNKNumberTextField: UITextField {
    
    weak var snkDelegate: SNKNumberTextFieldDelegate!
    
    enum Size {
        case big
        case small
    }
    
    var size: Size
    
    init(size: Size) {
        self.size = size
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
    
    override func caretRect(for position: UITextPosition) -> CGRect {
        switch size {
        case .big:
            var rect = super.caretRect(for: position)
            rect.size.height = 100
            return rect
        case .small:
            return super.caretRect(for: position)
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
        translatesAutoresizingMaskIntoConstraints = false
        switch size {
        case .big:
            font = UIFont.systemFont(ofSize: SNKFontSize.huge, weight: SNKFontWeight.forFontSizeHuge)
            attributedPlaceholder = NSAttributedString(string: "000", attributes: [NSAttributedString.Key.foregroundColor: SNKColor.backgroundGray])
            NSLayoutConstraint.activate([
                widthAnchor.constraint(equalToConstant: 195),
                heightAnchor.constraint(equalToConstant: 90)
            ])
        case .small:
            font = UIFont.systemFont(ofSize: SNKFontSize.big, weight: SNKFontWeight.forFontSizeBig)
            text = "0"
            NSLayoutConstraint.activate([
                widthAnchor.constraint(equalToConstant: SNKPadding.difViewWidth),
                heightAnchor.constraint(equalToConstant: SNKPadding.difViewHeight)
            ])
        }
        addTarget(self, action: #selector(editingChanged(sender:)), for: .editingChanged)
    }

    @objc func editingChanged(sender: SNKNumberTextField) { snkDelegate.snkNumberTextFieldEditingChanged(textField: sender) }

    func disable() {
        isEnabled = false
        layer.borderColor = SNKColor.backgroundSecondary.cgColor
    }
    
    func enable() {
        isEnabled = true
        layer.borderColor = SNKColor.foreground.cgColor
    }
    
    func useCurrentScores(dif: Int) {
        isEnabled = false
        layer.borderWidth = 0
        text = String(dif)
    }
    
    func useUserInput(lastUserInputDif: Int = 0) {
        isEnabled = true
        layer.borderWidth = 2
        text = String(lastUserInputDif)
    }

}
