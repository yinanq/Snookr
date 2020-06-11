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
        backgroundColor = SNKColor.backgroundGray
        layer.cornerRadius = SNKCornerRadius.big
        textContainerInset = UIEdgeInsets(top: SNKPadding.big, left: SNKPadding.big, bottom: SNKPadding.big, right: SNKPadding.big)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = SNKPadding.lineSpacingSmall
        paragraphStyle.alignment = .left
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: UIFont.systemFont(ofSize: SNKFontSize.regular, weight: .regular),
            .foregroundColor: SNKColor.foregroundWhite
        ]
        let text = "Create a 3-digit code to connect. Opponent must enter same code and hit connect on their app too."
        let maString = NSMutableAttributedString(string: text, attributes: attributes)
        attributedText = maString
        isEditable = false
        isScrollEnabled = false
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
