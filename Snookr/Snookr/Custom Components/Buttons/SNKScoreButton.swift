//
//  SNKScoreButton.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/9/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class SNKScoreButton: UIButton {
    
    enum Size: CGFloat {
        case small = 44
    }
    
    enum Symbol: String {
        case plusWithFill = "plus.circle.fill"
        case plus = "plus.circle"
        case minus = "minus.circle"
        case undo = "arrow.uturn.left.circle"
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(size: Size, symbol: Symbol, alpha: SNKAlpha = .opaque) {
        self.init(frame: .zero)
        setImage(UIImage(systemName: symbol.rawValue, withConfiguration: UIImage.SymbolConfiguration(pointSize: size.rawValue, weight: .ultraLight)), for: .normal)
        tintColor = UIColor(white: 1, alpha: alpha.rawValue)
    }
    
    convenience init(size: CGFloat, symbol: Symbol, alpha: SNKAlpha = .opaque) {
        self.init(frame: .zero)
        setImage(UIImage(systemName: symbol.rawValue, withConfiguration: UIImage.SymbolConfiguration(pointSize: size, weight: .ultraLight)), for: .normal)
        tintColor = UIColor(white: 1, alpha: alpha.rawValue)
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }

}
