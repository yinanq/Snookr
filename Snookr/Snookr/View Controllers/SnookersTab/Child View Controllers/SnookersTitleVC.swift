//
//  SnookersTitleVC.swift
//  Snookr
//
//  Created by Yinan Qiu on 6/2/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class SnookersTitleVC: UIViewController {
    
    let numberLabel = SNKLabel(fontSize: SNKFontSize.huge, fontWeight: SNKFontWeight.forFontSizeHuge, textAlignment: .left)
    let titleLabel = SNKLabel(fontSize: SNKFontSize.title, fontWeight: .bold, textAlignment: .left, numberOfLines: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
        configureChildren()
    }
    
    private func configureSelf() {
        overrideUserInterfaceStyle = .dark
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = SNKColor.backgroundSecondary
    }
    
    private func configureChildren() {
        numberLabel.text = "0"
        titleLabel.text = "snookers required"
        view.addSubviews(numberLabel, titleLabel)
        NSLayoutConstraint.activate([
            numberLabel.topAnchor.constraint(equalTo: view.topAnchor),
            numberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.bottomAnchor.constraint(equalTo: numberLabel.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: SNKPadding.tiny),
            titleLabel.bottomAnchor.constraint(equalTo: numberLabel.bottomAnchor)
        ])
    }

}
