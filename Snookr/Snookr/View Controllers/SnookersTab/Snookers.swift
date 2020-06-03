//
//  SnookersVC.swift
//  Snookr
//
//  Created by Yinan Qiu on 6/2/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class SnookersVC: UIViewController {
    
    let titleLabel = SNKLabel(fontSize: SNKFontSize.title, fontWeight: .bold, textAlignment: .left, numberOfLines: 0)
    let difTitleLabel = SNKLabel(fontSize: SNKFontSize.regular, fontWeight: SNKFontWeight.forFontSizeRegular, textAlignment: .left, numberOfLines: 0)
    let difSegControl = UISegmentedControl()
    let difTextField = SNKNumberTextField()
    let ballsTitleLable = SNKLabel(fontSize: SNKFontSize.regular, fontWeight: SNKFontWeight.forFontSizeRegular, textAlignment: .left, numberOfLines: 0)
    let ballsPicker = UIPickerView()
    let snookersTitle = SNKLabel(fontSize: SNKFontSize.regular, fontWeight: SNKFontWeight.forFontSizeRegular, textAlignment: .left, numberOfLines: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        configureViews()
        layoutViews()
    }
    
    private func configureViews() {
        configureTitleSection()
        configureDifSection()
        configureBallsSection()
        configureSnookersSection()
    }
    
    private func configureTitleSection() {
        titleLabel.text = "Snookers required?"
        view.addSubview(titleLabel)
    }
    
    private func configureDifSection() {
        difTitleLabel.text = "Score Difference"
        difSegControl.translatesAutoresizingMaskIntoConstraints = false
        difSegControl.insertSegment(withTitle: "By Current Scores", at: 0, animated: true)
        difSegControl.insertSegment(withTitle: "Enter New Difference", at: 1, animated: true)
        difSegControl.selectedSegmentIndex = 0
        difSegControl.selectedSegmentTintColor = SNKColor.background
        difSegControl.backgroundColor = SNKColor.backgroundSecondary
        difSegControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: SNKColor.foreground], for: .normal)
        view.addSubviews(difTitleLabel, difSegControl, difTextField)
    }
    
    private func configureSnookersSection() {
        snookersTitle.text = "Number of Snookers Required"
        view.addSubviews(snookersTitle)
    }
    
    private func configureBallsSection() {
        ballsTitleLable.text = "Balls Remaining"
        ballsPicker.translatesAutoresizingMaskIntoConstraints = false
        ballsPicker.backgroundColor = SNKColor.backgroundSecondary
        view.addSubviews(ballsTitleLable, ballsPicker)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: SNKPadding.big),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big),
            difTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: SNKPadding.big),
            difTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            difTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big),
            difSegControl.topAnchor.constraint(equalTo: difTitleLabel.bottomAnchor, constant: SNKPadding.small),
            difSegControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            difSegControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big),
            difTextField.topAnchor.constraint(equalTo: difSegControl.bottomAnchor, constant: SNKPadding.big),
            difTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ballsTitleLable.topAnchor.constraint(equalTo: difTextField.bottomAnchor, constant: SNKPadding.big),
            ballsTitleLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            ballsTitleLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big),
            ballsPicker.topAnchor.constraint(equalTo: ballsTitleLable.bottomAnchor, constant: SNKPadding.small),
            ballsPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            ballsPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big),
            snookersTitle.topAnchor.constraint(equalTo: ballsPicker.bottomAnchor, constant: SNKPadding.big),
            snookersTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            snookersTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big)
        ])
    }

}
