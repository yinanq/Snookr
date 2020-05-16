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
        lastScoreUpdateLabel1 = SNKLabel(fontSize: SNKFontSize.regular, fontWeight: .regular, textAlignment: .left)
        secondLastScoreUpdateLabel1 = SNKLabel(color: SNKColor.foregroundSecondary, fontSize: SNKFontSize.regular, fontWeight: .regular, textAlignment: .left)
        thirdLastScoreUpdateLabel1 = SNKLabel(color: SNKColor.foregroundTertiary, fontSize: SNKFontSize.regular, fontWeight: .regular, textAlignment: .left)
        lastScoreUpdateLabel2 = SNKLabel(fontSize: SNKFontSize.regular, fontWeight: .regular, textAlignment: .right)
        secondLastScoreUpdateLabel2 = SNKLabel(color: SNKColor.foregroundSecondary, fontSize: SNKFontSize.regular, fontWeight: .regular, textAlignment: .right)
        thirdLastScoreUpdateLabel2 = SNKLabel(color: SNKColor.foregroundTertiary, fontSize: SNKFontSize.regular, fontWeight: .regular, textAlignment: .right)
        [lastScoreUpdateLabel1,
         secondLastScoreUpdateLabel1,
         thirdLastScoreUpdateLabel1,
         lastScoreUpdateLabel2,
         secondLastScoreUpdateLabel2,
         thirdLastScoreUpdateLabel2
        ].forEach { label in
                addSubview(label!)
                label!.text = " " //keep empty string to prevent parent stack view from moving subview layout
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
    }
    
}
