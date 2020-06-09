//
//  ResetButton.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/13/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

protocol ResetButtonDelegate: class { func didTapResetButton() }

class ResetButton: SNKButton {
    
    weak var delegate: ResetButtonDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func configure() {
        set(title: "New Frame", style: .outline)
        addTarget(self, action: #selector(didTapResetButton), for: .touchUpInside)
    }
    
    @objc func didTapResetButton() { delegate.didTapResetButton() }
    
}
