//
//  PairButton.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/17/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

protocol PairButtonDelegate: class {
    func didTapPairButton()
}

import UIKit

class PairButton: UIButton {
    
    weak var delegate: PairButtonDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        setImage(UIImage(systemName: "link.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: SNKButtonSize.small, weight: .light)), for: .normal)
        setImage(UIImage(systemName: "link.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: SNKButtonSize.small, weight: .light)), for: .highlighted)
        tintColor = SNKColor.foregroundSecondary
        addTarget(self, action: #selector(didTapPairButton), for: .touchUpInside)
    }

    @objc func didTapPairButton() { delegate.didTapPairButton() }
}
