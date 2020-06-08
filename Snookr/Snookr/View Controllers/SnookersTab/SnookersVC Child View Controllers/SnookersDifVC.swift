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
    
    var currentScoreDif = 0
    var userInputDif = 0
    let difTitleLabel = SNKLabel(fontSize: SNKFontSize.regular, fontWeight: SNKFontWeight.forFontSizeRegular, textAlignment: .left, numberOfLines: 0)
    let difSegControl = UISegmentedControl()
    let difTextField = SNKNumberTextField(size: .small)
    let containerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
        configureChildren()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initCurrentScoreDif()
        updateCalculatorDelegate()
    }
    
    private func initCurrentScoreDif() {
        let defaults = UserDefaults.standard
        let score1 = defaults.integer(forKey: SNKCommonKey.player1sScore)
        let score2 = defaults.integer(forKey: SNKCommonKey.player2sScore)
        currentScoreDif = abs(score1 - score2)
        difTextField.useCurrentScores(dif: currentScoreDif)
        difSegControl.selectedSegmentIndex = 0
    }
    
    private func configureSelf() {
        overrideUserInterfaceStyle = .dark
        view.translatesAutoresizingMaskIntoConstraints = false
        NotificationCenter.default.addObserver(forName: .scoreboardVCDidChangeScoreDif, object: nil, queue: nil) { notif in
            self.currentScoreDif = notif.object as! Int
            if self.difSegControl.selectedSegmentIndex == 0 {
                self.difTextField.useCurrentScores(dif: self.currentScoreDif)
            }
        }
    }
    
    private func configureChildren() {
        difTitleLabel.text = "Difference"
        difSegControl.translatesAutoresizingMaskIntoConstraints = false
        difSegControl.insertSegment(withTitle: "Current Scores", at: 0, animated: true)
        difSegControl.insertSegment(withTitle: "Enter Difference", at: 1, animated: true)
        difSegControl.selectedSegmentIndex = 0
        difSegControl.selectedSegmentTintColor = SNKColor.foregroundWhite
        difSegControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: SNKColor.foregroundWhite], for: .normal)
        difSegControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: SNKColor.background], for: .selected)
        difSegControl.addTarget(self, action: #selector(difSegControlDidChangeValue), for: .valueChanged)
        difTextField.delegate = self
        difTextField.snkDelegate = self
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = SNKColor.backgroundGray
        containerView.layer.cornerRadius = SNKCornerRadius.big
        containerView.addSubviews(difSegControl, difTextField)
        view.addSubviews(difTitleLabel, containerView)
        NSLayoutConstraint.activate([
            difTitleLabel.topAnchor.constraint(equalTo: view.topAnchor),
            difTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            difTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: difTitleLabel.bottomAnchor, constant: SNKPadding.tiny),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            difSegControl.topAnchor.constraint(equalTo: containerView.topAnchor, constant: SNKPadding.small),
            difSegControl.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: SNKPadding.small),
            difSegControl.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -SNKPadding.small),
            difTextField.topAnchor.constraint(equalTo: difSegControl.bottomAnchor, constant: SNKPadding.small),
            difTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.bottomAnchor.constraint(equalTo: difTextField.bottomAnchor, constant: SNKPadding.small),
            view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    @objc func difSegControlDidChangeValue() {
        switch difSegControl.selectedSegmentIndex {
        case 0: difTextField.useCurrentScores(dif: currentScoreDif)
        case 1: difTextField.useUserInput(lastUserInputDif: userInputDif)
        default: print("invalid case in difSegControlDidChangeValue")
        }
        updateCalculatorDelegate()
    }
    
    private func updateCalculatorDelegate() {
        if let number = Int(difTextField.text ?? "0") {
            calculatorDelegate.snookersDifVCDidChangeDif(to: number)
        }
    }

}
