//
//  ScoreResetAlertVC.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/31/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit
import AVFoundation

protocol ScoreResetAlertVCDelegate: class { func didTapConfirmToReset(willAddFrame: Bool) }

class ScoreResetAlertVC: SNKAlertVC {
    
    weak var delegate: ScoreResetAlertVCDelegate!
    
    let addFrameLabel = SNKLabel(color: SNKColor.foregroundWhite, fontSize: SNKFontSize.regular, fontWeight: SNKFontWeight.forFontSizeRegular, textAlignment: .left, numberOfLines: 0)
    var willAddFrame = true
    
    init(title: String, body: String, cancelBtnTitle: String, confirmBtnTitile: String, delegate: ScoreResetAlertVCDelegate) {
        super.init(title: title, body: body, cancelBtnTitle: cancelBtnTitle, confirmBtnTitile: confirmBtnTitile)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmButton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
        configure()
    }
    
    @objc override func didTapConfirmButton() {
        super.didTapConfirmButton()
        AudioServicesPlaySystemSoundWithCompletion(SNKSoundID.didReset, nil)
        delegate.didTapConfirmToReset(willAddFrame: willAddFrame)
    }
    
    private func configure() {
        addFrameLabel.text = "+1 frame for winner"
        let addFrameSwitch = UISwitch()
        addFrameSwitch.translatesAutoresizingMaskIntoConstraints = false
        addFrameSwitch.onTintColor = SNKColor.foreground
        addFrameSwitch.isOn = true
        containerView.addSubviews(addFrameLabel, addFrameSwitch)
        buttonsViewTopC.isActive = false
        NSLayoutConstraint.activate([
            addFrameSwitch.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: SNKPadding.big),
            addFrameSwitch.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            addFrameLabel.centerYAnchor.constraint(equalTo: addFrameSwitch.centerYAnchor),
            addFrameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            buttonsView.topAnchor.constraint(equalTo: addFrameSwitch.bottomAnchor, constant: 45)
        ])
        addFrameSwitch.addTarget(self, action: #selector(didToggleSwitch(sender:)), for: .valueChanged)
    }
    
    @objc func didToggleSwitch(sender: UISwitch) {
        if sender.isOn {
            willAddFrame = true
            addFrameLabel.alpha = 1
        } else {
            willAddFrame = false
            addFrameLabel.alpha = 0.1
        }
    }
    
}
