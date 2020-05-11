//
//  PlayerNamesView.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/10/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class PlayerNamesView: UIView {
    
    var playerNameLabel1: SNKLabel!
    var playerNameLabel2: SNKLabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        playerNameLabel1 = SNKLabel(fontSize: SNKFontSize.regular, fontWeight: SNKFontWeightForFontSize.regular, textAlignment: .left, numberOfLines: 2)
        playerNameLabel2 = SNKLabel(fontSize: SNKFontSize.regular, fontWeight: SNKFontWeightForFontSize.regular, textAlignment: .right, numberOfLines: 2)
        let playerNameLabels = [playerNameLabel1, playerNameLabel2]
        for playerNameLabel in playerNameLabels {
            addSubview(playerNameLabel!)
            playerNameLabel!.topAnchor.constraint(equalTo: topAnchor).isActive = true
        }
        NSLayoutConstraint.activate([
            playerNameLabel1.leadingAnchor.constraint(equalTo: leadingAnchor),
            playerNameLabel1.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -SNKPadding.big),
            playerNameLabel2.leadingAnchor.constraint(equalTo: centerXAnchor, constant: SNKPadding.big),
            playerNameLabel2.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomAnchor.constraint(greaterThanOrEqualTo: playerNameLabel1.bottomAnchor),
            bottomAnchor.constraint(greaterThanOrEqualTo: playerNameLabel2.bottomAnchor)
        ])
//        backgroundColor = .systemTeal
    }

}
