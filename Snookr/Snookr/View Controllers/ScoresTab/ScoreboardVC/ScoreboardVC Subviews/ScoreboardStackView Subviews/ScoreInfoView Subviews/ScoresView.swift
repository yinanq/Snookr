//
//  ScoresView.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/9/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class ScoresView: UIView {

    let scoreDifView = ScoreDifView()
    var scoreLabel1: SNKLabel!
    var scoreLabel2: SNKLabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        scoreLabel1 = SNKLabel(fontSize: SNKFontSize.huge, fontWeight: SNKFontWeight.forFontSizeHuge, textAlignment: .left)
        scoreLabel2 = SNKLabel(fontSize: SNKFontSize.huge, fontWeight: SNKFontWeight.forFontSizeHuge, textAlignment: .right)
        let scoreLabels = [scoreLabel1, scoreLabel2]
        for scoreLable in scoreLabels {
            scoreLable!.adjustsFontSizeToFitWidth = true
            addSubview(scoreLable!)
            scoreLable!.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        }
        addSubview(scoreDifView)
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 80),
            scoreDifView.centerYAnchor.constraint(equalTo: centerYAnchor),
            scoreDifView.centerXAnchor.constraint(equalTo: centerXAnchor),
            scoreLabel1.leadingAnchor.constraint(equalTo: leadingAnchor),
            scoreLabel2.leadingAnchor.constraint(equalTo: scoreDifView.trailingAnchor, constant: SNKPadding.big),
            scoreLabel1.trailingAnchor.constraint(equalTo: scoreDifView.leadingAnchor, constant: -SNKPadding.big),
            scoreLabel2.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }

}
