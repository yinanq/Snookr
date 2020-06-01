//
//  ScoreResetAlertVC.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/31/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

protocol ScoreResetAlertVCDelegate: class {
    func didTapAddFrameToggle()
}

class ScoreResetAlertVC: ResetAlertVC {
    
    weak var winnerDelegate: ScoreResetAlertVCDelegate!
    
    let addFrameView = UIView()
    var addFrame = true
    
    init(title: String, body: String, cancelBtnTitle: String, confirmBtnTitile: String, delegate: ResetAlertVCDelegate, winnerDelegate: ScoreResetAlertVCDelegate) {
        super.init(title: title, body: body, cancelBtnTitle: cancelBtnTitle, confirmBtnTitile: confirmBtnTitile, delegate: delegate)
        self.winnerDelegate = winnerDelegate
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func configure() {
        addFrameView.translatesAutoresizingMaskIntoConstraints = false
        addFrameView.backgroundColor = SNKColor.backgroundSecondary
        view.addSubview(addFrameView)
        buttonsTopConstraint.isActive = false
        NSLayoutConstraint.activate([
            addFrameView.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 15),
            addFrameView.leadingAnchor.constraint(equalTo: bodyLabel.leadingAnchor),
            addFrameView.trailingAnchor.constraint(equalTo: bodyLabel.trailingAnchor),
            addFrameView.heightAnchor.constraint(equalToConstant: 50),
            buttonsView.topAnchor.constraint(equalTo: addFrameView.bottomAnchor, constant: 30)
        ])
    }
    
}
