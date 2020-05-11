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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        configureView()
        addLabels()
    }
    
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = SNKColor.backgroundSecondary
        layer.cornerRadius = SNKCornerRadius.small
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 65),
            heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    private func addLabels() {
        let titleLabel = SNKLabel(fontSize: SNKFontSize.small, fontWeight: SNKFontWeightForFontSize.small, textAlignment: .center)
        differenceLabel = SNKLabel(fontSize: SNKFontSize.big, fontWeight: .bold, textAlignment: .center)
        titleLabel.text = "DIFFERENCE"
        differenceLabel.text = "81"
        differenceLabel.adjustsFontSizeToFitWidth = true
        let labels = [titleLabel, differenceLabel]
        for label in labels {
            addSubview(label!)
            label!.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        }
        addSubviews(titleLabel, differenceLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            differenceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            differenceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: SNKPadding.small),
            differenceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -SNKPadding.small)
        ])
    }
    
    func update(difference: Int) {
        differenceLabel.text = String(difference)
    }

}
