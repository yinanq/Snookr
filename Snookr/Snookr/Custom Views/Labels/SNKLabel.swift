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
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    convenience init(color: UIColor = SNKColor.foreground, fontSize: CGFloat, fontWeight: UIFont.Weight, textAlignment: NSTextAlignment = .center, numberOfLines: Int = 1) {
        self.init(frame: .zero)
        textColor = color
        font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        lineBreakMode = .byTruncatingTail
        baselineAdjustment = .alignCenters
    }

}
