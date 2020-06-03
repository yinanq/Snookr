//
//  SnookersDifVC.swift
//  Snookr
//
//  Created by Yinan Qiu on 6/2/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class SnookersDifVC: UIViewController {
    
    let difTitleLabel = SNKLabel(fontSize: SNKFontSize.regular, fontWeight: SNKFontWeight.forFontSizeRegular, textAlignment: .left, numberOfLines: 0)
    let difSegControl = UISegmentedControl()
    let difTextField = SNKNumberTextField()

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
        difTitleLabel.text = "Score Difference"
        difSegControl.translatesAutoresizingMaskIntoConstraints = false
        difSegControl.insertSegment(withTitle: "By Current Scores", at: 0, animated: true)
        difSegControl.insertSegment(withTitle: "Enter New Difference", at: 1, animated: true)
        difSegControl.selectedSegmentIndex = 0
        difSegControl.selectedSegmentTintColor = SNKColor.background
        difSegControl.backgroundColor = SNKColor.backgroundSecondary
        difSegControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: SNKColor.foreground], for: .normal)
        view.addSubviews(difTitleLabel, difSegControl, difTextField)
        NSLayoutConstraint.activate([
            difTitleLabel.topAnchor.constraint(equalTo: view.topAnchor),
            difTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            difTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            difSegControl.topAnchor.constraint(equalTo: difTitleLabel.bottomAnchor, constant: SNKPadding.small),
            difSegControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            difSegControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            difTextField.topAnchor.constraint(equalTo: difSegControl.bottomAnchor, constant: SNKPadding.big),
            difTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            view.bottomAnchor.constraint(equalTo: difTextField.bottomAnchor)
        ])
    }

}
