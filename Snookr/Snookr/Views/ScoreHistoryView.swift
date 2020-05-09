//
//  ScoreHistoryView.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/9/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class ScoreHistoryView: UIView {

    let lastScoreUpdateLabel1 = SNKLabel(fontSize: SNKFontSize.regular, fontWeight: .light, textAlignment: .left, alpha: SNKAlpha.transparentHighOpacity)
    let secondLastScoreUpdateLabel1 = SNKLabel(fontSize: SNKFontSize.regular, fontWeight: .light, textAlignment: .left, alpha: SNKAlpha.transparentMidOpacity)
    let thirdLastScoreUpdateLabel1 = SNKLabel(fontSize: SNKFontSize.regular, fontWeight: .light, textAlignment: .left, alpha: SNKAlpha.transparentLowOpacity)
    let lastScoreUpdateLabel2 = SNKLabel(fontSize: SNKFontSize.regular, fontWeight: .light, textAlignment: .right, alpha: SNKAlpha.transparentHighOpacity)
    let secondLastScoreUpdateLabel2 = SNKLabel(fontSize: SNKFontSize.regular, fontWeight: .light, textAlignment: .right, alpha: SNKAlpha.transparentMidOpacity)
    let thirdLastScoreUpdateLabel2 = SNKLabel(fontSize: SNKFontSize.regular, fontWeight: .light, textAlignment: .right, alpha: SNKAlpha.transparentLowOpacity)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        addLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func addLabels() {
        addSubview(lastScoreUpdateLabel1)
        addSubview(secondLastScoreUpdateLabel1)
        addSubview(thirdLastScoreUpdateLabel1)
        addSubview(lastScoreUpdateLabel2)
        addSubview(secondLastScoreUpdateLabel2)
        addSubview(thirdLastScoreUpdateLabel2)
        let labels = [lastScoreUpdateLabel1, secondLastScoreUpdateLabel1, thirdLastScoreUpdateLabel1, lastScoreUpdateLabel2, secondLastScoreUpdateLabel2, thirdLastScoreUpdateLabel2]
        for label in labels { label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true }
        NSLayoutConstraint.activate([
            lastScoreUpdateLabel1.leadingAnchor.constraint(equalTo: leadingAnchor),
            secondLastScoreUpdateLabel1.leadingAnchor.constraint(equalTo: lastScoreUpdateLabel1.trailingAnchor, constant: SNKPadding.small),
            thirdLastScoreUpdateLabel1.leadingAnchor.constraint(equalTo: secondLastScoreUpdateLabel1.trailingAnchor, constant: SNKPadding.small),
            lastScoreUpdateLabel2.trailingAnchor.constraint(equalTo: trailingAnchor),
            secondLastScoreUpdateLabel2.trailingAnchor.constraint(equalTo: lastScoreUpdateLabel2.leadingAnchor, constant: -SNKPadding.small),
            thirdLastScoreUpdateLabel2.trailingAnchor.constraint(equalTo: secondLastScoreUpdateLabel2.leadingAnchor, constant: -SNKPadding.small),
        ])
    }

}
