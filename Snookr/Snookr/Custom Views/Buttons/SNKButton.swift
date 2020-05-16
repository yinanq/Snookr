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
        case naked
        case numberPad
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
        layer.cornerRadius = SNKCornerRadius.big
    }
    
    func set(title: String, style: Style) {
        setTitle(title, for: .normal)
        switch style {
        case .solid:
            heightAnchor.constraint(equalToConstant: 60).isActive = true
            backgroundColor = SNKColor.foreground
            titleLabel?.font = UIFont.systemFont(ofSize: SNKFontSize.regular, weight: SNKFontWeight.forFontSizeRegular)
            setTitleColor(SNKColor.background, for: .normal)
            setTitleColor(SNKColor.foregroundSecondary, for: .highlighted)
        case .outline:
            heightAnchor.constraint(equalToConstant: 60).isActive = true
            titleLabel?.font = UIFont.systemFont(ofSize: SNKFontSize.regular, weight: SNKFontWeight.forFontSizeRegular)
            setTitleColor(SNKColor.foreground, for: .normal)
            setTitleColor(SNKColor.backgroundSecondary, for: .highlighted)
            layer.borderColor = SNKColor.foreground.cgColor
            layer.borderWidth = 2
        case .naked:
            heightAnchor.constraint(equalToConstant: 44).isActive = true
            titleLabel?.font = UIFont.systemFont(ofSize: SNKFontSize.regular, weight: SNKFontWeight.forFontSizeRegular)
            setTitleColor(SNKColor.foreground, for: .normal)
            setTitleColor(SNKColor.backgroundSecondary, for: .highlighted)
        case .numberPad:
            backgroundColor = SNKColor.backgroundSecondary
            titleLabel?.font = UIFont.systemFont(ofSize: 36, weight: .thin)
            setTitleColor(SNKColor.foreground, for: .normal)
            setTitleColor(SNKColor.foregroundSecondary, for: .highlighted)
            layer.borderColor = SNKColor.foreground.cgColor
            layer.borderWidth = 0.5
            layer.cornerRadius = SNKCornerRadius.small
            imageView?.contentMode = .scaleAspectFit
        }
    }
    
    func enableSolidStyleButton() {
        isEnabled = true
        backgroundColor = SNKColor.foreground
    }
    func disableSolidStyleButton() {
        isEnabled = false
        backgroundColor = SNKColor.backgroundSecondary
    }

}
