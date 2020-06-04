//
//  SnookersTitleVC.swift
//  Snookr
//
//  Created by Yinan Qiu on 6/2/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class SnookersTitleVC: UIViewController {
    
    var toTie = false
    var titleText: String {
        if toTie {
            return "4-point snookers to tie"
        } else {
            return "4-point snookers to win"
        }
    }
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
        titleLabel.text = titleText
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
