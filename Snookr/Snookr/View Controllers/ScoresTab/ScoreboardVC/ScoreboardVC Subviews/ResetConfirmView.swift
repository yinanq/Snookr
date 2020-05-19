//
//  ResetConfirmView.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/15/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

protocol ResetConfirmViewDelegate: class {
    func didTapConfirmResetButton()
}

class ResetConfirmView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    convenience init(delegate: ResetConfirmViewDelegate) {
        self.init(frame: .zero)
        self.delegate = delegate
    }
    
    var delegate: ResetConfirmViewDelegate!
    
    var titleLabel: SNKLabel!
    var bodyLabel: SNKLabel!
    let buttonsView = UIView()
    var cancelButton: SNKButton!
    var confirmButton: SNKButton!
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = SNKColor.background.withAlphaComponent(SNKAlpha.dimmer.rawValue)
        configureSubviews()
        addButtonTargets()
        alpha = 0
        UIView.animate(withDuration: SNKAnimationDuration.short, delay: 0, options: .curveEaseInOut, animations: { self.alpha = 1 })
    }
    
    private func configureSubviews() {
        titleLabel = SNKLabel(fontSize: SNKFontSize.huge, fontWeight: SNKFontWeight.forFontSizeHuge)
        bodyLabel = SNKLabel(fontSize: SNKFontSize.regular, fontWeight: SNKFontWeight.forFontSizeRegular, numberOfLines: 0)
        titleLabel.text = "Sure?"
        bodyLabel.text = "Gonna reset the scores. Sure you wanna do it?" //serious tone alt: "Scores will reset. Are you sure you want to start a new frame?"
        cancelButton = SNKButton(title: "No", style: .solid)
        confirmButton = SNKButton(title: "Yes", style: .solid)
        [cancelButton, confirmButton].forEach { button in
            buttonsView.addSubview(button!)
            button?.widthAnchor.constraint(equalTo: buttonsView.widthAnchor, multiplier: 0.5, constant: -SNKPadding.big/2).isActive = true
        }
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        [titleLabel, bodyLabel, buttonsView].forEach { subview in
            addSubview(subview!)
            subview?.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        }
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: bodyLabel.topAnchor, constant: -SNKPadding.big),
            bodyLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -15),
            bodyLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: SNKLayoutPercent.bodyTextWidth),
            buttonsView.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 45),
            buttonsView.widthAnchor.constraint(equalTo: bodyLabel.widthAnchor, constant: -5),
            cancelButton.topAnchor.constraint(equalTo: buttonsView.topAnchor),
            confirmButton.topAnchor.constraint(equalTo: buttonsView.topAnchor),
            cancelButton.leadingAnchor.constraint(equalTo: buttonsView.leadingAnchor),
            confirmButton.trailingAnchor.constraint(equalTo: buttonsView.trailingAnchor),
            buttonsView.bottomAnchor.constraint(equalTo: cancelButton.bottomAnchor)
        ])
    }
    
    private func addButtonTargets() {
        cancelButton.addTarget(self, action: #selector(didTapCancelResetButton), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(didTapConfirmResetButton), for: .touchUpInside)
    }
    
    @objc func didTapCancelResetButton() { removeFromSuperviewWithAnimation() }
    
    @objc func didTapConfirmResetButton() {
        removeFromSuperviewWithAnimation()
        delegate.didTapConfirmResetButton()
    }
    
    private func removeFromSuperviewWithAnimation() {
        UIView.animate(withDuration: SNKAnimationDuration.short, delay: 0, options: .curveEaseInOut, animations: {
            self.alpha = 0
        }) { _ in
            self.removeFromSuperview()
        }
    }
    
}
