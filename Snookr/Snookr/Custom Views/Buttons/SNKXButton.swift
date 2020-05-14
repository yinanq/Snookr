//
//  SNKXButton.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/14/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class SNKXButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        setImage(UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: SNKButtonSize.smallerVisual, weight: .light)), for: .normal)
        tintColor = SNKColor.foreground
        widthAnchor.constraint(equalToConstant: SNKButtonSize.small).isActive = true
        heightAnchor.constraint(equalToConstant: SNKButtonSize.small).isActive = true
    }
    
}
