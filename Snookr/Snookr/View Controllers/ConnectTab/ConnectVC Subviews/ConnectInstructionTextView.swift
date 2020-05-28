//
//  ConnectInstructionTextView.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/27/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class ConnectInstructionTextView: UITextView {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func configure() {
        text = "Create a 3-digit code and Connect. Opponent nearby must enter same code and hit Connect on their app."
        font = UIFont.systemFont(ofSize: SNKFontSize.regular, weight: .regular)
        textColor = SNKColor.foreground
        textAlignment = .center
        isEditable = false
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 300),
            heightAnchor.constraint(equalToConstant: 82)
        ])
        hide()
    }
    
    func hide() { isHidden = true }
    
    func unhide() { isHidden = false }
    
}
