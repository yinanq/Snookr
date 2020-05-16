//
//  ResetConfirmVC.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/15/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

protocol ResetConfirmVCDelegate: class {
    func didTapConfirmResetButton()
}

//not used. using view version instead, becuase modalTransitionStyle crossDissolve disables button interactivity during too long transition animation.
class ResetConfirmVC: UIViewController {
    
    init(delegate: ResetConfirmVCDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var delegate: ResetConfirmVCDelegate!
    
    var titleLabel: SNKLabel!
    var bodyLabel: SNKLabel!
    let buttonsView = UIView()
    var cancelButton: SNKButton!
    var confirmButton: SNKButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = SNKColor.background.withAlphaComponent(SNKAlpha.dimmer.rawValue)
        configureSubviews()
        addButtonTargets()
    }
    
    private func configureSubviews() {
        titleLabel = SNKLabel(fontSize: SNKFontSize.huge, fontWeight: SNKFontWeight.forFontSizeHuge)
        bodyLabel = SNKLabel(fontSize: SNKFontSize.regular, fontWeight: SNKFontWeight.forFontSizeRegular, numberOfLines: 0)
        titleLabel.text = "Sure?"
        bodyLabel.text = "Scores will reset. Are you sure you want to start a new frame?"
        cancelButton = SNKButton(title: "No", style: .solid)
        confirmButton = SNKButton(title: "Yes", style: .solid)
        [cancelButton, confirmButton].forEach { button in
            buttonsView.addSubview(button!)
            button?.widthAnchor.constraint(equalTo: buttonsView.widthAnchor, multiplier: 0.5, constant: -SNKPadding.big/2).isActive = true
        }
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        [titleLabel, bodyLabel, buttonsView].forEach { subview in
            view.addSubview(subview!)
            subview?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        }
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: bodyLabel.topAnchor, constant: -SNKPadding.big),
            bodyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -15),
            bodyLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: SNKLayoutPercent.bodyTextWidth),
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
    
    @objc func didTapCancelResetButton() { dismiss(animated: true) }
    
    @objc func didTapConfirmResetButton() {
        dismiss(animated: true)
        delegate.didTapConfirmResetButton()
    }

}
