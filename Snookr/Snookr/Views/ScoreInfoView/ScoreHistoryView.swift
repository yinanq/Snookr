//
//  ScoreHistoryView.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/9/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class ScoreHistoryView: UIView {

    var lastScoreUpdateLabel1: SNKLabel!
    var secondLastScoreUpdateLabel1: SNKLabel!
    var thirdLastScoreUpdateLabel1: SNKLabel!
    var lastScoreUpdateLabel2: SNKLabel!
    var secondLastScoreUpdateLabel2: SNKLabel!
    var thirdLastScoreUpdateLabel2: SNKLabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        lastScoreUpdateLabel1 = SNKLabel(fontSize: SNKFontSize.regular, fontWeight: .light, textAlignment: .left, alpha: SNKAlpha.opaque.rawValue)
        secondLastScoreUpdateLabel1 = SNKLabel(fontSize: SNKFontSize.regular, fontWeight: .light, textAlignment: .left, alpha: SNKAlpha.transparentHighOpacity.rawValue)
        thirdLastScoreUpdateLabel1 = SNKLabel(fontSize: SNKFontSize.regular, fontWeight: .light, textAlignment: .left, alpha: SNKAlpha.transparentLowOpacity.rawValue)
        lastScoreUpdateLabel2 = SNKLabel(fontSize: SNKFontSize.regular, fontWeight: .light, textAlignment: .right, alpha: SNKAlpha.opaque.rawValue)
        secondLastScoreUpdateLabel2 = SNKLabel(fontSize: SNKFontSize.regular, fontWeight: .light, textAlignment: .right, alpha: SNKAlpha.transparentHighOpacity.rawValue)
        thirdLastScoreUpdateLabel2 = SNKLabel(fontSize: SNKFontSize.regular, fontWeight: .light, textAlignment: .right, alpha: SNKAlpha.transparentLowOpacity.rawValue)
        let labels = [lastScoreUpdateLabel1, secondLastScoreUpdateLabel1, thirdLastScoreUpdateLabel1, lastScoreUpdateLabel2, secondLastScoreUpdateLabel2, thirdLastScoreUpdateLabel2]
        for label in labels {
            addSubview(label!)
            label!.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        }
        NSLayoutConstraint.activate([
            lastScoreUpdateLabel1.topAnchor.constraint(equalTo: topAnchor),
            bottomAnchor.constraint(equalTo: lastScoreUpdateLabel1.bottomAnchor),
            lastScoreUpdateLabel1.leadingAnchor.constraint(equalTo: leadingAnchor),
            secondLastScoreUpdateLabel1.leadingAnchor.constraint(equalTo: lastScoreUpdateLabel1.trailingAnchor, constant: SNKPadding.small),
            thirdLastScoreUpdateLabel1.leadingAnchor.constraint(equalTo: secondLastScoreUpdateLabel1.trailingAnchor, constant: SNKPadding.small),
            lastScoreUpdateLabel2.trailingAnchor.constraint(equalTo: trailingAnchor),
            secondLastScoreUpdateLabel2.trailingAnchor.constraint(equalTo: lastScoreUpdateLabel2.leadingAnchor, constant: -SNKPadding.small),
            thirdLastScoreUpdateLabel2.trailingAnchor.constraint(equalTo: secondLastScoreUpdateLabel2.leadingAnchor, constant: -SNKPadding.small),
        ])
//        backgroundColor = .systemTeal
    }

}
