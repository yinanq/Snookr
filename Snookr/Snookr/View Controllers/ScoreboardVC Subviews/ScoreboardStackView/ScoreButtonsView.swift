//
//  ScoreButtonsView.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/10/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class ScoreButtonsView: UIView {
    
    var plusButton1: SNKScoreButton!
    var plusButton2: SNKScoreButton!
    var plusOneButton1: SNKScoreButton!
    var plusOneButton2: SNKScoreButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        let plusButtonSize = (UIScreen.main.bounds.width - SNKPadding.big * 4 - separatorViewWidth) / 2
        plusButton1 = SNKScoreButton(size: plusButtonSize, symbol: .plusWithFill)
        plusButton2 = SNKScoreButton(size: plusButtonSize, symbol: .plusWithFill)
        plusOneButton1 = SNKScoreButton(size: .small, symbol: .plus)
        plusOneButton2 = SNKScoreButton(size: .small, symbol: .plus)
        addSubviews(plusButton1, plusButton2, plusOneButton1, plusOneButton2)
        NSLayoutConstraint.activate([
            //vertical:
            plusButton1.topAnchor.constraint(equalTo: topAnchor),
            plusOneButton1.topAnchor.constraint(equalTo: plusButton1.bottomAnchor, constant: SNKPadding.negative),
            plusOneButton2.topAnchor.constraint(equalTo: plusButton1.bottomAnchor, constant: SNKPadding.negative),
            bottomAnchor.constraint(equalTo: plusOneButton1.bottomAnchor),
            //horizontal:
            plusButton1.centerXAnchor.constraint(equalTo: leadingAnchor, constant: (UIScreen.main.bounds.width-4*SNKPadding.big-separatorViewWidth)/4 ),
            plusButton2.centerXAnchor.constraint(equalTo: trailingAnchor, constant: -(UIScreen.main.bounds.width-4*SNKPadding.big-separatorViewWidth)/4 ),
            plusOneButton1.leadingAnchor.constraint(equalTo: leadingAnchor),
            plusOneButton2.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
//        backgroundColor = .systemIndigo
    }

}
