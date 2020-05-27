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
    let meLabel = SNKLabel(color: SNKColor.foreground, fontSize: SNKFontSize.regular, fontWeight: .regular, textAlignment: .right)
    let opponentLabel = SNKLabel(color: SNKColor.foreground, fontSize: SNKFontSize.regular, fontWeight: .regular, textAlignment: .left)
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
        toggleButton.tintColor = SNKColor.foreground
        toggleButton.setImage(UIImage(systemName: "arrow.right.arrow.left.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: SNKButtonSize.small, weight: .thin)), for: .normal)
        toggleButton.setImage(UIImage(systemName: "arrow.right.arrow.left.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: SNKButtonSize.small, weight: .thin)), for: .highlighted)
        
        meLabel.text = meStr
        opponentLabel.text = opStr
        
        NSLayoutConstraint.activate([
            toggleButton.topAnchor.constraint(equalTo: topAnchor),
            toggleButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            meLabel.leadingAnchor.constraint(equalTo: toggleButton.trailingAnchor),
            meLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -SNKPadding.textViewAdjusterTextAlignedSide),
            meLabel.centerYAnchor.constraint(equalTo: toggleButton.centerYAnchor),
            opponentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: SNKPadding.textViewAdjusterTextAlignedSide),
            opponentLabel.trailingAnchor.constraint(equalTo: toggleButton.leadingAnchor),
            opponentLabel.centerYAnchor.constraint(equalTo: toggleButton.centerYAnchor),
            heightAnchor.constraint(equalTo: toggleButton.heightAnchor)
        ])
        
        toggleButton.addTarget(self, action: #selector(didTapToggleButton), for: .touchUpInside)
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
//        toggleButton.isEnabled = false
        toggleButton.isUserInteractionEnabled = false
        toggleButton.tintColor = SNKColor.backgroundSecondary
    }
    func unlockToggleButton() {
//        toggleButton.isEnabled = true
        toggleButton.isUserInteractionEnabled = true
        toggleButton.tintColor = SNKColor.foreground
    }
    
}
