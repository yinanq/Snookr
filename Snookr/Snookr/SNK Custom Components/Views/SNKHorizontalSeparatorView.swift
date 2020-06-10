//
//  SNKHorizontalSeparatorView.swift
//  Snookr
//
//  Created by Yinan Qiu on 6/10/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class SNKHorizontalSeparatorView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = SNKColor.foregroundWhite
        layer.cornerRadius = SNKPadding.separatorViewWidth / 2
        heightAnchor.constraint(equalToConstant: SNKPadding.separatorViewWidth).isActive = true
    }
}
