//
//  SNKSettingsCell.swift
//  Snookr
//
//  Created by Yinan Qiu on 6/10/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class SNKSettingsCell: UITableViewCell {
    
    static let reuseID = "SNKSettingsCell"
    let titleLabel = SNKLabel(color: SNKColor.foreground, fontSize: SNKFontSize.regular, fontWeight: SNKFontWeight.forFontSizeRegular, textAlignment: .left)
    let seperatorView = SNKHorizontalSeparatorView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSelf()
        configureChildren()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func configureSelf() {
        accessoryView = UIImageView(image: UIImage.init(systemName: "chevron.compact.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: SNKButtonSize.smallerVisual, weight: .light)))
        tintColor = SNKColor.foreground
        let view = UIView()
        view.backgroundColor = SNKColor.foregroundWhite
        selectedBackgroundView = view
    }
    
    private func configureChildren() {
        addSubviews(titleLabel, seperatorView)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: SNKPadding.big),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            seperatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: SNKPadding.big),
            seperatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -SNKPadding.big),
            seperatorView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setTitleText(to text: String) { titleLabel.text = text }

}
