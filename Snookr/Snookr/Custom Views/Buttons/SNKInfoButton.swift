//
//  SNKInfoButton.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/12/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class SNKInfoButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        setImage(UIImage(systemName: "info.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: SNKButtonSize.small, weight: .thin)), for: .normal)
        setImage(UIImage(systemName: "info.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: SNKButtonSize.small, weight: .thin)), for: .highlighted)
        tintColor = SNKColor.foregroundSecondary
    }
    
}
