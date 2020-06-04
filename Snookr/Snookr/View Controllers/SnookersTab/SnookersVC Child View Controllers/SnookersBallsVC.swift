//
//  SnookersBallsVC.swift
//  Snookr
//
//  Created by Yinan Qiu on 6/2/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

protocol SnookersBallsVCDelegate: class {
    func snookersBallsVCPickerDidSelect(ballsTotalPoints: Int)
    func snookersBallsVCPickerDidUnselect()
}

class SnookersBallsVC: UIViewController {
    
    weak var delegate: SnookersBallsVCDelegate!
    
    let ballsTitleLable = SNKLabel(fontSize: SNKFontSize.regular, fontWeight: SNKFontWeight.forFontSizeRegular, textAlignment: .left, numberOfLines: 0)
    let ballsPicker = UIPickerView()
    let ballsPickerOptionStrings = [
        "Select",
        "Pink",
        "Blue",
        "Brown",
        "Green",
        "Yellow",
        "One Red",
        "Two Reds",
        "Three Reds",
        "Four Reds",
        "Five Reds"
    ]
    let ballsTotalPoints = [
        13, //pink
        18, //blue
        22, //brown
        25, //green
        27, //yellow
        35, //1 red
        43, //2 reds
        51, //3 reds
        59, //4 reds
        67, //5 reds
    ]

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
        ballsTitleLable.text = "Colors Remaining"
        ballsPicker.translatesAutoresizingMaskIntoConstraints = false
        ballsPicker.delegate = self
        ballsPicker.backgroundColor = SNKColor.backgroundGrey
        ballsPicker.layer.cornerRadius = SNKCornerRadius.big
        view.addSubviews(ballsTitleLable, ballsPicker)
        NSLayoutConstraint.activate([
            ballsTitleLable.topAnchor.constraint(equalTo: view.topAnchor),
            ballsTitleLable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            ballsTitleLable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ballsPicker.topAnchor.constraint(equalTo: ballsTitleLable.bottomAnchor, constant: SNKPadding.tiny),
            ballsPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            ballsPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: ballsPicker.bottomAnchor)
        ])
    }

}
