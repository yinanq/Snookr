//
//  SNKInfoButton.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/12/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class SNKInfoButton: UIButton {

    enum Size: CGFloat {
            case small = 44
        }

        override init(frame: CGRect) {
            super.init(frame: frame)
            configure()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func configure() {
            translatesAutoresizingMaskIntoConstraints = false
            setImage(UIImage(systemName: "info.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 44, weight: .ultraLight)), for: .normal)
            setImage(UIImage(systemName: "info.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 44, weight: .ultraLight)), for: .highlighted)
            tintColor = SNKColor.backgroundSecondary
        }

}
