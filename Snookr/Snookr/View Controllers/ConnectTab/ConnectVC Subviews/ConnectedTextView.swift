//
//  ConnectedTextView.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/27/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class ConnectedTextView: SNKTextView {
    
    var maStringForNotConnected: NSMutableAttributedString!
    var maStringForConnected: NSMutableAttributedString!

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
        let notConnectedText = "When connected, scores auto sync via Bluetooth between two Snookr apps. When not connected, Snookr is a standalone scoreboard."
        let connectedText = "Now Connected\nScores are auto synced on every update. You and your opponent can each update from your own app. Open Scores tab and give it a try!"
        maStringForNotConnected = NSMutableAttributedString(string: notConnectedText, attributes: attributes)
        maStringForConnected = NSMutableAttributedString(string: connectedText, attributes: attributes)
        let attributesForTitle: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: SNKFontSize.regular, weight: SNKFontWeight.forFontSizeRegular),
            .foregroundColor: SNKColor.foreground
        ]
        maStringForConnected.addAttributes(attributesForTitle, range: NSRange(location: 0, length: 14))
        isEditable = false
        isUserInteractionEnabled = false
        setToNotConnected()
    }
    
    func setToNotConnected() { attributedText = maStringForNotConnected }
    
    func setToConnected() { attributedText = maStringForConnected }

}
