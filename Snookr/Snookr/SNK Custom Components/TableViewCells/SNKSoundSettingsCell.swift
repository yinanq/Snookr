//
//  SNKSoundSettingsCell.swift
//  Snookr
//
//  Created by Yinan Qiu on 6/10/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class SNKSoundSettingsCell: UITableViewCell {
    
    static let reuseID = "SNKSoundSettingsCell"
    let titleLabel = SNKLabel(color: SNKColor.foreground, fontSize: SNKFontSize.regular, fontWeight: SNKFontWeight.forFontSizeRegular, textAlignment: .left)
    let bodyTextView = SNKBodyTextView()
    let checkMarkView = UIImageView(image: UIImage(systemName: "smallcircle.fill.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: SNKButtonSize.smallerVisual, weight: .light)))

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSelf()
        configureChildren()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func configureSelf() {
        tintColor = SNKColor.foreground
        let view = UIView()
        view.backgroundColor = SNKColor.foregroundWhite
        selectedBackgroundView = view
    }
    
    private func configureChildren() {
        checkMarkView.translatesAutoresizingMaskIntoConstraints = false
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubviews(titleLabel, bodyTextView)
        let seperatorView = SNKHorizontalSeparatorView()
        addSubviews(checkMarkView, containerView, seperatorView)
        NSLayoutConstraint.activate([
            checkMarkView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor, constant: -1),
            checkMarkView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: SNKPadding.big),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: SNKPadding.huge),
            containerView.leadingAnchor.constraint(equalTo: checkMarkView.trailingAnchor, constant: SNKPadding.small),
            containerView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -SNKPadding.big),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            bodyTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: SNKPadding.big),
            bodyTextView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            bodyTextView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bodyTextView.bottomAnchor),
            seperatorView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: SNKPadding.huge),
            seperatorView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            seperatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -SNKPadding.big),
            bottomAnchor.constraint(equalTo: seperatorView.bottomAnchor)
        ])
        checkMarkView.alpha = 0
    }
    
    func setToSelectedSkipAnimation() { checkMarkView.alpha = 1 }
    
    func setToSelected() {
        checkMarkView.transform = CGAffineTransform(scaleX: SNKAnimationScale.shrinkALot, y: SNKAnimationScale.shrinkALot)
        animateToIdentityWithDelay()
    }
    
    private func animateToIdentityWithDelay() {
        UIView.animate(withDuration: SNKAnimationDuration.short, delay: SNKAnimationDuration.short, options: [], animations: {
            self.checkMarkView.alpha = 1
            self.checkMarkView.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    func setToUnselected() {
        UIView.animate(withDuration: SNKAnimationDuration.short) {
            self.checkMarkView.alpha = 0
            self.checkMarkView.transform = CGAffineTransform(scaleX: SNKAnimationScale.shrinkALot, y: SNKAnimationScale.shrinkALot)
        }
    }
    
    func setTitleText(to text: String) { titleLabel.text = text }
    
    func setBodyText(to text: String) { bodyTextView.setText(to: text) }

}
