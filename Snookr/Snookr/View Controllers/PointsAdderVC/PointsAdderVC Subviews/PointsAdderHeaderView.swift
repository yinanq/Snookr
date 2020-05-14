//
//  PointsAdderHeaderView.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/13/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class PointsAdderHeaderView: UIView {
    
    var titleLabel: SNKLabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(player: Player) {
        self.init(frame: .zero)
        titleLabel.text = "Points for \(player.name)"
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel = SNKLabel(fontSize: SNKFontSize.regular, fontWeight: .bold, textAlignment: .center)
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
}
