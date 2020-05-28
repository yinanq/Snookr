//
//  ConnectedTextView.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/27/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class ConnectedTextView: UITextView {
    
    let notConnectedText = "When connected, scores will auto sync via Bluetooth. You and your opponent each update your own score from your own app. If not connected, you can use Snookr as a standalone scoreboard."
    let connectedText = "Now connected, scores will auto sync via Bluetooth. You and your opponent each update your own score from your own app. Go to Scores tab and give it a try!"

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func configure() {
        font = UIFont.systemFont(ofSize: SNKFontSize.regular, weight: .regular)
        textAlignment = .center
        isEditable = false
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: SNKBodyWidth.fixed),
            heightAnchor.constraint(equalToConstant: 128)
        ])
        setToNotConnected()
    }
    
    func setToNotConnected() {
        text = notConnectedText
        textColor = SNKColor.foregroundSecondary
    }
    
    func setToConnected() {
        text = connectedText
        textColor = SNKColor.foreground
    }

}
