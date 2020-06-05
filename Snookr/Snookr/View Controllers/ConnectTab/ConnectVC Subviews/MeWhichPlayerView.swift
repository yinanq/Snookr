//
//  MeWhichPlayerView.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/22/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

protocol MeWhichPlayerViewDelegate: class {
    func didTapToggleButton()
}

import UIKit

class MeWhichPlayerView: UIView {
    
    weak var delegate: MeWhichPlayerViewDelegate!
    
    let toggleButton = UIButton()
    let meLabel = SNKLabel(color: SNKColor.foregroundSecondary, fontSize: SNKFontSize.regular, fontWeight: SNKFontWeight.forFontSizeRegular, textAlignment: .right)
    let opponentLabel = SNKLabel(color: SNKColor.foregroundSecondary, fontSize: SNKFontSize.regular, fontWeight: SNKFontWeight.forFontSizeRegular, textAlignment: .left)
    let meStr = "me"
    let opStr = "opponent"

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    convenience init(delegate: MeWhichPlayerViewDelegate) {
        self.init(frame: .zero)
        self.delegate = delegate
    }
    
    private func configure() {
        backgroundColor = SNKColor.background
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(toggleButton, meLabel, opponentLabel)
        
        toggleButton.translatesAutoresizingMaskIntoConstraints = false
        toggleButton.setImage(UIImage(systemName: "arrow.right.arrow.left.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: SNKButtonSize.small, weight: .thin)), for: .normal)
        toggleButton.setImage(UIImage(systemName: "arrow.right.arrow.left.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: SNKButtonSize.small, weight: .thin)), for: .highlighted)
        
        meLabel.text = meStr
        opponentLabel.text = opStr
        
        NSLayoutConstraint.activate([
            toggleButton.topAnchor.constraint(equalTo: topAnchor),
            toggleButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            meLabel.leadingAnchor.constraint(equalTo: toggleButton.trailingAnchor),
            meLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            meLabel.centerYAnchor.constraint(equalTo: toggleButton.centerYAnchor),
            opponentLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            opponentLabel.trailingAnchor.constraint(equalTo: toggleButton.leadingAnchor),
            opponentLabel.centerYAnchor.constraint(equalTo: toggleButton.centerYAnchor),
            heightAnchor.constraint(equalTo: toggleButton.heightAnchor)
        ])
        
        toggleButton.addTarget(self, action: #selector(didTapToggleButton), for: .touchUpInside)
        
        unlockToggleButton()
    }
    
    @objc func didTapToggleButton() { delegate.didTapToggleButton() }
    
    func setOpponentToPlayer1() {
        opponentLabel.text = opStr
        meLabel.text = meStr
    }
    func setOpponentToPlayer2() {
        opponentLabel.text = meStr
        meLabel.text = opStr
    }
    
    func lockToggleButton() {
        toggleButton.isUserInteractionEnabled = false
        toggleButton.tintColor = SNKColor.backgroundGray
    }
    func unlockToggleButton() {
        toggleButton.isUserInteractionEnabled = true
        toggleButton.tintColor = SNKColor.foregroundSecondary
    }
    
}
