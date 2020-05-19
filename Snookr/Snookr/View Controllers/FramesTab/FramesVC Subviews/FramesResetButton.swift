//
//  FramesResetButton.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/18/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

protocol FramesResetButtonDelegate: class {
    func didTapFramesResetButton()
}

class FramesResetButton: SNKButton {

    weak var delegate: FramesResetButtonDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func configure() {
        set(title: "Reset", style: .outline)
        addTarget(self, action: #selector(didTapFramesResetButton), for: .touchUpInside)
    }
    
    @objc func didTapFramesResetButton() { delegate.didTapFramesResetButton() }

}
