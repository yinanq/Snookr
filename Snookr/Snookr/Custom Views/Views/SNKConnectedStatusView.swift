//
//  SNKConnectedStatusView.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/26/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class SNKConnectedStatusView: UIView {
    
    let label = SNKLabel(fontSize: SNKFontSize.small, fontWeight: SNKFontWeight.forFontSizeSmall)
    
    enum text: String {
        case connected = "CONNECTED"
        case resetScores = "OPPONENT JUST RESET SCORES"
        case resetFrames = "OPPONENT JUST RESET FRAMES"
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = SNKColor.backgroundSecondary
        translatesAutoresizingMaskIntoConstraints = false
        label.text = text.connected.rawValue
        addSubview(label)
        NSLayoutConstraint.activate([
//            heightAnchor.constraint(equalToConstant: 50),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -SNKPadding.tiny),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        alpha = 1
    }
}
