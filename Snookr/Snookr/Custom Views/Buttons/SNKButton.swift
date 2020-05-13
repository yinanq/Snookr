//
//  SNKButton.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/9/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class SNKButton: UIButton {
    
    enum Style {
        case solid
        case outline
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, style: Style) {
        self.init(frame: .zero)
        set(title: title, style: style)
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 60).isActive = true
        layer.cornerRadius = SNKCornerRadius.big
        setTitleColor(SNKColor.backgroundSecondary, for: .highlighted)
    }
    
    func set(title: String, style: Style) {
        setTitle(title, for: .normal)
        switch style {
        case .solid:
            setTitleColor(SNKColor.background, for: .normal)
            backgroundColor = SNKColor.button
            titleLabel?.font = UIFont.systemFont(ofSize: SNKFontSize.regular, weight: .bold)
        case .outline:
            setTitleColor(SNKColor.text, for: .normal)
            layer.borderColor = SNKColor.button.cgColor
            layer.borderWidth = 2
            titleLabel?.font = UIFont.systemFont(ofSize: SNKFontSize.big, weight: .regular)
        }
    }

}
