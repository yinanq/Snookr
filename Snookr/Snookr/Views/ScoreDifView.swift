//
//  ScoreDifView.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/9/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class ScoreDifView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        addLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = SNKColor.backgroundSecondary
        layer.cornerRadius = SNKCornerRadius.small
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 65),
            heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    private func addLabels() {
        let metricNameLabel = SNKLabel(fontSize: SNKFontSize.small, fontWeight: SNKFontWeightForFontSize.small, textAlignment: .center)
        let metricValueLabel = SNKLabel(fontSize: 24, fontWeight: .semibold, textAlignment: .center)
        metricNameLabel.text = "DIFFERENCE"
        metricValueLabel.text = "64"
        metricValueLabel.adjustsFontSizeToFitWidth = true
        addSubview(metricNameLabel)
        addSubview(metricValueLabel)
        NSLayoutConstraint.activate([
            metricNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            metricNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            metricValueLabel.topAnchor.constraint(equalTo: metricNameLabel.bottomAnchor),
            metricValueLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            metricValueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: SNKPadding.small),
            metricValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -SNKPadding.small)
        ])
    }

}
