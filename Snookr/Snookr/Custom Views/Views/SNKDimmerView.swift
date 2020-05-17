//
//  SNKDimmerView.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/11/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class SNKDimmerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func configure() {
        frame = UIScreen.main.bounds
        backgroundColor = SNKColor.background.withAlphaComponent(SNKAlpha.dimmer.rawValue)
    }

}
