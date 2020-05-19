//
//  InfoButtonView.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/13/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

protocol InfoButtonViewDelegate: class {
    func didTapInfoButton()
}

class InfoButtonView: UIView {
    
    weak var delegate: InfoButtonViewDelegate!
    
    let infoButton = InfoButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    convenience init (delegate: InfoButtonViewDelegate) {
        self.init(frame: .zero)
        self.delegate = delegate
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(infoButton)
        NSLayoutConstraint.activate([
            infoButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            infoButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            topAnchor.constraint(equalTo: infoButton.topAnchor)
        ])
        infoButton.addTarget(self, action: #selector(didTapInfoButton), for: .touchUpInside)
    }
    
    @objc func didTapInfoButton() { delegate.didTapInfoButton() }

}
