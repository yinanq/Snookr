//
//  SnookersDifVC.swift
//  Snookr
//
//  Created by Yinan Qiu on 6/2/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

protocol SnookersDifVCTextFieldDelegate: class {
    func snookersDifVCsnkNumberTextFieldDidBeginEditing()
    func snookersDifVCsnkTextFieldDidEndEditing()
}

protocol SnookersDifVCCalculatorDelegate: class {
    func snookersDifVCDidChangeDif(to newDif: Int)
}

class SnookersDifVC: UIViewController {
    
    weak var textFieldDelegate: SnookersDifVCTextFieldDelegate!
    weak var calculatorDelegate: SnookersDifVCCalculatorDelegate!
    
    let defaults = UserDefaults.standard
    var currentScoreDif = 0
    var userInputDif = 0
    let difTitleLabel = SNKLabel(fontSize: SNKFontSize.regular, fontWeight: SNKFontWeight.forFontSizeRegular, textAlignment: .left, numberOfLines: 0)
    let difSegControl = UISegmentedControl()
    let difTextField = SNKNumberTextField(size: .small)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
        configureChildren()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateCurrentScoreDif()
    }
    
    private func updateCurrentScoreDif() {
        let score1 = defaults.integer(forKey: SNKCommonKey.player1sScore)
        let score2 = defaults.integer(forKey: SNKCommonKey.player2sScore)
        currentScoreDif = abs(score1 - score2)
        difTextField.useCurrentScores(dif: currentScoreDif)
        difSegControl.selectedSegmentIndex = 0
    }
    
    private func configureSelf() {
        overrideUserInterfaceStyle = .dark
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureChildren() {
        difTitleLabel.text = "Difference"
        difSegControl.translatesAutoresizingMaskIntoConstraints = false
        difSegControl.insertSegment(withTitle: "Current Scores", at: 0, animated: true)
        difSegControl.insertSegment(withTitle: "Enter Difference", at: 1, animated: true)
        difSegControl.selectedSegmentIndex = 0
        difSegControl.selectedSegmentTintColor = SNKColor.backgroundSecondary
        difSegControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: SNKColor.foreground], for: .normal)
        difSegControl.addTarget(self, action: #selector(difSegControlDidChangeValue), for: .valueChanged)
        difTextField.delegate = self
        difTextField.snkDelegate = self
        view.addSubviews(difTitleLabel, difSegControl, difTextField)
        NSLayoutConstraint.activate([
            difTitleLabel.topAnchor.constraint(equalTo: view.topAnchor),
            difTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            difTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            difSegControl.topAnchor.constraint(equalTo: difTitleLabel.bottomAnchor, constant: SNKPadding.small),
            difSegControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            difSegControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            difTextField.topAnchor.constraint(equalTo: difSegControl.bottomAnchor, constant: 16),
            difTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            view.bottomAnchor.constraint(equalTo: difTextField.bottomAnchor)
        ])
    }
    
    @objc func difSegControlDidChangeValue() {
        switch difSegControl.selectedSegmentIndex {
        case 0: difTextField.useCurrentScores(dif: currentScoreDif)
        case 1: difTextField.useUserInput(lastUserInputDif: userInputDif)
        default: print("invalid case in difSegControlDidChangeValue")
        }
    }

}
