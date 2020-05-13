//
//  SNKScoreButton.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/9/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class SNKScoreButton: UIButton {
    
    enum Symbol: String {
        case plus = "plus.circle"
        case plusWithFill = "plus.circle.fill"
        case one = "1.circle"
        case oneWithFill = "1.circle.fill"
        case undo = "arrow.uturn.left.circle"
        case undoWithFill = "arrow.uturn.left.circle.fill"
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(normalSymbol: Symbol, highlightedSymbol: Symbol) {
        self.init(frame: .zero)
        setImage(UIImage(systemName: normalSymbol.rawValue, withConfiguration: UIImage.SymbolConfiguration(pointSize: SNKButtonSize.small, weight: .thin)), for: .normal)
        setImage(UIImage(systemName: highlightedSymbol.rawValue, withConfiguration: UIImage.SymbolConfiguration(pointSize: SNKButtonSize.small, weight: .thin)), for: .highlighted)
    }
    
    convenience init(normalSymbol: Symbol, highlightedSymbol: Symbol, size: CGFloat, weight: UIImage.SymbolWeight) {
        self.init(frame: .zero)
        setImage(UIImage(systemName: normalSymbol.rawValue, withConfiguration: UIImage.SymbolConfiguration(pointSize: size, weight: weight)), for: .normal)
        setImage(UIImage(systemName: highlightedSymbol.rawValue, withConfiguration: UIImage.SymbolConfiguration(pointSize: size, weight: weight)), for: .highlighted)
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        tintColor = SNKColor.foreground
    }

}
