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
    
    var scoreDif = 0
    var ballsTotalPoints: Int?

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
        resetNumberOfSnookersRequired()
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
    
    func updateNumberOfSnookersRequired(scoreDif: Int, ballsTotalPoints: Int) {
        var perSnookerPoints = 4
        if ballsTotalPoints == 13 {
            perSnookerPoints = 6
        } else if ballsTotalPoints == 18 {
            perSnookerPoints = 5
        }
        if scoreDif <= ballsTotalPoints {
            resetNumberOfSnookersRequired()
        } else {
            let dif = scoreDif - ballsTotalPoints
            if dif < perSnookerPoints {
                numberLabel.text = "1"
                titleLabel.text = "\(perSnookerPoints)-point snooker to win"
            } else if dif == perSnookerPoints {
                numberLabel.text = "1"
                titleLabel.text = "\(perSnookerPoints)-point snooker to tie"
            } else {
                let remainder = dif % perSnookerPoints
                var number = dif / perSnookerPoints
                if remainder == 0 {
                    numberLabel.text = String(number)
                    if number == 1 {
                        titleLabel.text = "\(perSnookerPoints)-point snooker to tie"
                    } else {
                        titleLabel.text = "\(perSnookerPoints)-point snookers to tie"
                    }
                } else {
                    number = number + 1
                    numberLabel.text = String(number)
                    if number == 1 {
                        titleLabel.text = "\(perSnookerPoints)-point snooker to win"
                    } else {
                        titleLabel.text = "\(perSnookerPoints)-point snookers to win"
                    }
                }
                if number > 5 { numberLabel.text = "5+" }
            }
        }
    }
    
    func resetNumberOfSnookersRequired() {
        numberLabel.text = "0"
        titleLabel.text = "snookers required"
    }

}
