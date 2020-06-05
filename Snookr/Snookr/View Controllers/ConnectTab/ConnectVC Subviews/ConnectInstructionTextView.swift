//
//  ConnectInstructionTextView.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/27/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class ConnectInstructionTextView: SNKTextView {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func configure() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = SNKPadding.lineSpacing
        paragraphStyle.alignment = .left
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: UIFont.systemFont(ofSize: SNKFontSize.regular, weight: SNKFontWeight.forFontSizeRegular),
            .foregroundColor: SNKColor.foreground,
        ]
        let text = "Create a 3-digit code and connect. Ask opponent nearby to enter same code and hit connect on their app too."
        let maString = NSMutableAttributedString(string: text, attributes: attributes)
        attributedText = maString
        isEditable = false
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        alpha = 0
    }
    
    func hide() {
        UIView.animate(withDuration: SNKAnimationDuration.short) {
            self.alpha = 0
        }
    }
    
    func unhide() {
        UIView.animate(withDuration: SNKAnimationDuration.short) {
            self.alpha = 1
        }
    }
    
}
