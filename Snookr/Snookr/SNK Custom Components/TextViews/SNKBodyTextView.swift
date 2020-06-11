//
//  SNKBodyTextView.swift
//  Snookr
//
//  Created by Yinan Qiu on 6/10/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class SNKBodyTextView: UITextView {
    
    var attributes: [NSAttributedString.Key: Any]!

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func configure() {
        textContainer.lineFragmentPadding = 0
        textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        textAlignment = .left
        backgroundColor = nil
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        isScrollEnabled = false
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = SNKPadding.lineSpacingSmall
        paragraphStyle.alignment = .left
        attributes = [
            .paragraphStyle: paragraphStyle,
            .font: UIFont.systemFont(ofSize: SNKFontSize.regular, weight: .regular),
            .foregroundColor: SNKColor.foregroundWhite
        ]
    }
    
    func setText(to text: String) { attributedText = NSAttributedString(string: text, attributes: attributes) }

}
