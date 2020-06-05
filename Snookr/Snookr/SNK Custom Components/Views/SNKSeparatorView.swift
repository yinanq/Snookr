//
//  SNKSeparatorView.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/10/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class SNKSeparatorView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = SNKColor.backgroundGray
        layer.cornerRadius = SNKPadding.separatorViewWidth / 2
        widthAnchor.constraint(equalToConstant: SNKPadding.separatorViewWidth).isActive = true
    }
}
