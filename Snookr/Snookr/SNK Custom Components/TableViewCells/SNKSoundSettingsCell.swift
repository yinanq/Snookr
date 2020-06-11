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
    let statusView = UIView()
    var statusViewWidth: NSLayoutConstraint!
    let statusViewWidthConstant: CGFloat = 45

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
        let checkMark = UIImage(systemName: "smallcircle.fill.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: SNKButtonSize.smallerVisual, weight: .light))
        let checkMarkView = UIImageView(image: checkMark)
        checkMarkView.translatesAutoresizingMaskIntoConstraints = false
        statusView.addSubview(checkMarkView)
        statusView.alpha = 0
        statusView.translatesAutoresizingMaskIntoConstraints = false
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubviews(titleLabel, bodyTextView)
        let seperatorView = SNKHorizontalSeparatorView()
        addSubviews(statusView, containerView, seperatorView)
        statusViewWidth = statusView.widthAnchor.constraint(equalToConstant: 0)
        NSLayoutConstraint.activate([
            statusView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: SNKPadding.big),
            statusViewWidth,
            statusView.topAnchor.constraint(equalTo: containerView.topAnchor),
            statusView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            checkMarkView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor, constant: -1),
            checkMarkView.leadingAnchor.constraint(equalTo: statusView.leadingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: SNKPadding.huge),
            containerView.leadingAnchor.constraint(equalTo: statusView.trailingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -SNKPadding.big),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            bodyTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: SNKPadding.big),
            bodyTextView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            bodyTextView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bodyTextView.bottomAnchor),
            seperatorView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: SNKPadding.huge),
            seperatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: SNKPadding.big),
            seperatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -SNKPadding.big),
            bottomAnchor.constraint(equalTo: seperatorView.bottomAnchor)
        ])
    }
    
    func setToSelectedSkipAnimation() {
        self.statusView.alpha = 1
        self.statusViewWidth.constant = statusViewWidthConstant
    }
    
    func setToSelected() {
        UIView.animate(withDuration: SNKAnimationDuration.short, animations: {
            self.statusViewWidth.constant = self.statusViewWidthConstant
            self.layoutIfNeeded()
        }) { _ in
            UIView.animate(withDuration: SNKAnimationDuration.supershort) {
                self.statusView.alpha = 1
            }
        }
    }
    
    func setToUnselected() {
        UIView.animate(withDuration: SNKAnimationDuration.supershort, animations: {
            self.statusView.alpha = 0
        }) { _ in
            UIView.animate(withDuration: SNKAnimationDuration.short) {
                self.statusViewWidth.constant = 0
                self.layoutIfNeeded()
            }
        }
    }
    
    func setTitleText(to text: String) { titleLabel.text = text }
    
    func setBodyText(to text: String) { bodyTextView.setText(to: text) }

}
