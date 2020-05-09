//
//  SNKButton.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/9/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class SNKButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, titleColor: UIColor) {
        self.init(frame: .zero)
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 60).isActive = true
        backgroundColor = SNKColor.button
        layer.cornerRadius = SNKCornerRadius.big
        titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    }

}
