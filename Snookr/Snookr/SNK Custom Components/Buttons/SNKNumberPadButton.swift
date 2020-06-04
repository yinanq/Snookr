//
//  SNKNumberPadButton.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/14/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class SNKNumberPadButton: UIButton {

    enum Symbol: String {
        case delete = "delete.left"
        case deleteF = "delete.left.fill"
        case k1 = "1.circle"
        case k1F = "1.circle.fill"
        case k2 = "2.circle"
        case k2F = "2.circle.fill"
        case k3 = "3.circle"
        case k3F = "3.circle.fill"
        case k4 = "4.circle"
        case k4F = "4.circle.fill"
        case k5 = "5.circle"
        case k5F = "5.circle.fill"
        case k6 = "6.circle"
        case k6F = "6.circle.fill"
        case k7 = "7.circle"
        case k7F = "7.circle.fill"
        case k8 = "8.circle"
        case k8F = "8.circle.fill"
        case k9 = "9.circle"
        case k9F = "9.circle.fill"
        case k0 = "0.circle"
        case k0F = "0.circle.fill"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    convenience init(normalSymbol: Symbol, highlightedSymbol: Symbol, size: CGFloat = 100, weight: UIImage.SymbolWeight = .ultraLight, contentMode: UIView.ContentMode = .scaleAspectFit) {
        self.init(frame: .zero)
        setImage(UIImage(systemName: normalSymbol.rawValue, withConfiguration: UIImage.SymbolConfiguration(pointSize: size, weight: weight)), for: .normal)
        setImage(UIImage(systemName: highlightedSymbol.rawValue, withConfiguration: UIImage.SymbolConfiguration(pointSize: size, weight: weight)), for: .highlighted)
        imageView?.contentMode = contentMode
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        tintColor = SNKColor.foreground
    }

}
