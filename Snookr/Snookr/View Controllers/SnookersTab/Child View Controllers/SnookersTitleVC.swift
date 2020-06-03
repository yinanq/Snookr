//
//  SnookersTitleVC.swift
//  Snookr
//
//  Created by Yinan Qiu on 6/2/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class SnookersTitleVC: UIViewController {
    
    let numberLabel = SNKLabel(fontSize: SNKFontSize.gigantic, fontWeight: SNKFontWeight.forFontSizeGigantic, textAlignment: .left)
    let titleLabel = SNKLabel(fontSize: SNKFontSize.title, fontWeight: .bold, textAlignment: .left, numberOfLines: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
        configureChildren()
    }
    
    private func configureSelf() {
        overrideUserInterfaceStyle = .dark
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureChildren() {
        numberLabel.text = "0"
        titleLabel.text = "snookers required to win"
        view.addSubviews(numberLabel, titleLabel)
        NSLayoutConstraint.activate([
            numberLabel.topAnchor.constraint(equalTo: view.topAnchor),
            numberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.bottomAnchor.constraint(equalTo: numberLabel.bottomAnchor),
            titleLabel.lastBaselineAnchor.constraint(equalTo: numberLabel.lastBaselineAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

}
