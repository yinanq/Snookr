//
//  ConnectedTextView.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/27/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class ConnectedTextView: UITextView {
    
    let notConnectedText = "When connected, scores auto sync via Bluetooth between two Snookr apps. When not connected, Snookr is a standalone scoreboard."
    let connectedText = "Now connected, scores auto sync. You and your opponent can each update from your own app. Open Scores tab and give it a try!"

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
            .foregroundColor: SNKColor.foregroundTertiary,
        ]
        let maString = NSMutableAttributedString(string: notConnectedText, attributes: attributes)
        attributedText = maString
        isEditable = false
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            widthAnchor.constraint(equalToConstant: SNKBodyWidth.fixed),
//            heightAnchor.constraint(equalToConstant: 140)
//        ])
        widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 2 * (SNKPadding.big - SNKPadding.textViewAdjusterBodyText)).isActive = true
        clipsToBounds = false
        setToNotConnected()
    }
    
    func setToNotConnected() {
        text = notConnectedText
        textColor = SNKColor.foregroundGray
    }
    
    func setToConnected() {
        text = connectedText
        textColor = SNKColor.foreground
    }

}
