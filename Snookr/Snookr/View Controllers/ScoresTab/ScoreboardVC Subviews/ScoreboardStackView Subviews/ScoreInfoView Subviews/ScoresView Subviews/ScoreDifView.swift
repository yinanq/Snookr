//
//  ScoreDifView.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/9/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class ScoreDifView: UIView {
    
    var differenceLabel: SNKLabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func configure() {
        configureView()
        addLabels()
    }
    
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderColor = SNKColor.foregroundWhite.cgColor
        layer.borderWidth = SNKPadding.separatorViewWidth
        layer.cornerRadius = SNKCornerRadius.big
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: SNKPadding.difViewWidth),
            heightAnchor.constraint(equalToConstant: SNKPadding.difViewHeight)
        ])
    }
    
    private func addLabels() {
        differenceLabel = SNKLabel(color: SNKColor.foregroundWhite, fontSize: SNKFontSize.big, fontWeight: SNKFontWeight.forFontSizeBig, textAlignment: .center)
        differenceLabel.adjustsFontSizeToFitWidth = true
        addSubview(differenceLabel)
        NSLayoutConstraint.activate([
            differenceLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            differenceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: SNKPadding.small),
            differenceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -SNKPadding.small)
        ])
    }
    
    func set(_ difference: Int) { differenceLabel.text = String(difference) }

}
