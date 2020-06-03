//
//  SnookersBallsVC.swift
//  Snookr
//
//  Created by Yinan Qiu on 6/2/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class SnookersBallsVC: UIViewController {
    
    let ballsTitleLable = SNKLabel(fontSize: SNKFontSize.regular, fontWeight: SNKFontWeight.forFontSizeRegular, textAlignment: .left, numberOfLines: 0)
    let ballsPicker = UIPickerView()

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
        ballsTitleLable.text = "Balls Remaining"
        ballsPicker.translatesAutoresizingMaskIntoConstraints = false
        ballsPicker.backgroundColor = SNKColor.backgroundSecondary
        view.addSubviews(ballsTitleLable, ballsPicker)
        NSLayoutConstraint.activate([
            ballsTitleLable.topAnchor.constraint(equalTo: view.topAnchor),
            ballsTitleLable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            ballsTitleLable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ballsPicker.topAnchor.constraint(equalTo: ballsTitleLable.bottomAnchor, constant: SNKPadding.small),
            ballsPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            ballsPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: ballsPicker.bottomAnchor)
        ])
    }

}
