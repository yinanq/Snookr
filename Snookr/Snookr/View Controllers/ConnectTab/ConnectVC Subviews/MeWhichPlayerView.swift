//
//  MeWhichPlayerView.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/22/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class MeWhichPlayerView: UIView {
    
    let toggleButton = UIButton()
    let meLabel = SNKLabel(color: SNKColor.foregroundSecondary, fontSize: SNKFontSize.regular, fontWeight: SNKFontWeight.forFontSizeRegular, textAlignment: .left)
    let opponentLabel = SNKLabel(color: SNKColor.foregroundSecondary, fontSize: SNKFontSize.regular, fontWeight: SNKFontWeight.forFontSizeRegular, textAlignment: .right)
    let meStr = "me"
    let opStr = "opponent"

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = SNKColor.background
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(toggleButton, meLabel, opponentLabel)
        
        toggleButton.translatesAutoresizingMaskIntoConstraints = false
        toggleButton.tintColor = SNKColor.foregroundSecondary
        toggleButton.setImage(UIImage(systemName: "arrow.right.arrow.left.square.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: SNKButtonSize.small, weight: .thin)), for: .normal)
        toggleButton.setImage(UIImage(systemName: "arrow.right.arrow.left.square", withConfiguration: UIImage.SymbolConfiguration(pointSize: SNKButtonSize.small, weight: .thin)), for: .highlighted)
        
        meLabel.text = meStr
        opponentLabel.text = opStr
        
        NSLayoutConstraint.activate([
            toggleButton.topAnchor.constraint(equalTo: topAnchor),
            toggleButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            meLabel.leadingAnchor.constraint(equalTo: toggleButton.trailingAnchor),
            meLabel.centerYAnchor.constraint(equalTo: toggleButton.centerYAnchor),
            opponentLabel.trailingAnchor.constraint(equalTo: toggleButton.leadingAnchor),
            opponentLabel.centerYAnchor.constraint(equalTo: toggleButton.centerYAnchor),
            heightAnchor.constraint(equalTo: toggleButton.heightAnchor)
        ])
        
        toggleButton.addTarget(self, action: #selector(fakeToggle), for: .touchUpInside)
    }
    
    @objc func fakeToggle() {
        if meLabel.text == meStr && opponentLabel.text == opStr {
            meLabel.text = opStr
            opponentLabel.text = meStr
        } else if meLabel.text == opStr && opponentLabel.text == meStr {
            meLabel.text = meStr
            opponentLabel.text = opStr
        } else {
            print("error in fakeToggle")
        }
    }
    
}
