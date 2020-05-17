//
//  PairedStatusView.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/16/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

protocol PairedStatusViewDelegate: class {
    func didTapPairedStatusView()
}

import UIKit

class PairedStatusView: UIView {
    
    weak var delegate: PairedStatusViewDelegate!
    
    let tapRecognizer = UITapGestureRecognizer()
    
    var pairedStatusLabel: SNKLabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        devTemp_setInitialStatusToHidden()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = SNKColor.backgroundSecondary
        
        pairedStatusLabel = SNKLabel(fontSize: SNKFontSize.small, fontWeight: SNKFontWeight.forFontSizeSmall, textAlignment: .center)
        pairedStatusLabel.text = "IN SYNC WITH OPPONENT'S APP"
        
        addSubview(pairedStatusLabel)
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 90),
            pairedStatusLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            pairedStatusLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -SNKPadding.tiny)
        ])
        
        addGestureRecognizer(tapRecognizer)
        tapRecognizer.addTarget(self, action: #selector(didTapPairedStatusView))
    }
    
    @objc func didTapPairedStatusView() { delegate.didTapPairedStatusView() }
    
    private func devTemp_setInitialStatusToHidden() { isHidden = true }
    
}
