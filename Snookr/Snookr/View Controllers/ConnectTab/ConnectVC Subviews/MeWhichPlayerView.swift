//
//  MeWhichPlayerView.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/22/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit
import AVFoundation

protocol MeWhichPlayerViewDelegate: class { func didTapToggleButton() }

class MeWhichPlayerView: UIView {
    
    weak var delegate: MeWhichPlayerViewDelegate!
    
    let toggleButton = UIButton()
    let meLabel = SNKLabel(color: SNKColor.foregroundWhite, fontSize: SNKFontSize.regular, fontWeight: SNKFontWeight.forFontSizeRegular)
    let opponentLabel = SNKLabel(color: SNKColor.foregroundWhite, fontSize: SNKFontSize.regular, fontWeight: SNKFontWeight.forFontSizeRegular)
    var opponentLabelLeading: NSLayoutConstraint!
    var opponentLabelTrailing: NSLayoutConstraint!
    var meLabelLeading: NSLayoutConstraint!
    var meLabelTrailing: NSLayoutConstraint!

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
        toggleButton.translatesAutoresizingMaskIntoConstraints = false
        toggleButton.setImage(UIImage(systemName: "arrow.right.arrow.left.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: SNKButtonSize.small, weight: .thin)), for: .normal)
        toggleButton.setImage(UIImage(systemName: "arrow.right.arrow.left.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: SNKButtonSize.small, weight: .thin)), for: .highlighted)
        opponentLabel.text = "opponent"
        meLabel.text = "me"
        addSubviews(opponentLabel, meLabel, toggleButton)
        meLabelLeading = meLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
        meLabelTrailing = meLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        opponentLabelLeading = opponentLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
        opponentLabelTrailing = opponentLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        NSLayoutConstraint.activate([
            toggleButton.topAnchor.constraint(equalTo: topAnchor),
            toggleButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            meLabel.centerYAnchor.constraint(equalTo: toggleButton.centerYAnchor),
            opponentLabel.centerYAnchor.constraint(equalTo: toggleButton.centerYAnchor),
            meLabel.centerYAnchor.constraint(equalTo: toggleButton.centerYAnchor),
            heightAnchor.constraint(equalTo: toggleButton.heightAnchor)
        ])
        toggleButton.addTarget(self, action: #selector(didTapToggleButton), for: .touchUpInside)
        unlockToggleButton()
    }
    
    @objc func didTapToggleButton() {
        AudioServicesPlaySystemSoundWithCompletion(SNKSoundID.didTap, nil)
        delegate.didTapToggleButton()
    }
    
    func setOpponentToPlayer1() {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            self.opponentLabelLeading.isActive = true
            self.opponentLabelTrailing.isActive = false
            self.meLabelLeading.isActive = false
            self.meLabelTrailing.isActive = true
            self.layoutIfNeeded()
        }, completion: nil)
    }
    func setOpponentToPlayer2() {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            self.opponentLabelLeading.isActive = false
            self.opponentLabelTrailing.isActive = true
            self.meLabelLeading.isActive = true
            self.meLabelTrailing.isActive = false
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    func lockToggleButton() {
        toggleButton.isUserInteractionEnabled = false
        toggleButton.tintColor = SNKColor.backgroundGray
    }
    func unlockToggleButton() {
        toggleButton.isUserInteractionEnabled = true
        toggleButton.tintColor = SNKColor.foregroundWhite
    }
    
}
