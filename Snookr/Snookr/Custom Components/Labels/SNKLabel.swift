//
//  SNKLabel.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/9/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class SNKLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(fontSize: CGFloat, fontWeight: UIFont.Weight, textAlignment: NSTextAlignment, numberOfLines: Int = 1, alpha: SNKAlpha = .opaque) {
        self.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
        self.alpha = alpha.rawValue
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        textColor = SNKColor.text
        lineBreakMode = .byTruncatingTail
        baselineAdjustment = .alignCenters
    }

}
