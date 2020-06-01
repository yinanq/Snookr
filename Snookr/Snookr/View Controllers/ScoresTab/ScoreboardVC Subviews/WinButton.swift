//
//  WinButton.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/31/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

protocol WinButtonDelegate: class {
    func didTapWinButton()
}

class WinButton: SNKButton {
    
    weak var delegate: WinButtonDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func configure() {
        set(title: "Win", style: .outline)
        addTarget(self, action: #selector(didTapWinButton), for: .touchUpInside)
    }
    
    @objc func didTapWinButton() { delegate.didTapWinButton() }
    
}
