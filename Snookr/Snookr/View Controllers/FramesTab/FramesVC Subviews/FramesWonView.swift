//
//  FramesWonView.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/18/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class FramesWonView: UIView {

    var framesWonLabel1: SNKLabel!
    var framesWonLabel2: SNKLabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        framesWonLabel1 = SNKLabel(fontSize: 170, fontWeight: SNKFontWeight.forFontSizeHuge, textAlignment: .left)
        framesWonLabel2 = SNKLabel(fontSize: 170, fontWeight: SNKFontWeight.forFontSizeHuge, textAlignment: .right)
        [framesWonLabel1, framesWonLabel2].forEach { label in
            label?.adjustsFontSizeToFitWidth = true
            addSubview(label!)
            label?.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        }
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 150),
            framesWonLabel1.leadingAnchor.constraint(equalTo: leadingAnchor),
            framesWonLabel1.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -SNKPadding.big),
            framesWonLabel2.leadingAnchor.constraint(equalTo: centerXAnchor, constant: SNKPadding.big),
            framesWonLabel2.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }

}
