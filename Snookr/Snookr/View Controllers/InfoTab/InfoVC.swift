//
//  InfoVC.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/13/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class InfoVC: UIViewController {
    
    let headerView = UIVisualEffectView()
    let logoImageView = UIImageView()
    var bodyScrollView = UIScrollView()
    var bodyTextView = SNKTextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        configureChildViews()
    }
    
    private func configureChildViews() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.effect = UIBlurEffect(style: .regular)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "logo-green")
        let string = "The Scoreboard\nTo get the most out of this scoreboard, you and your opponent at the snooker table can each use your own Snookr app on your own iPhone in the Bluetooth-connected mode. Of course, you can also choose not to turn on Bluetooth connection and just update both players' scores from one Snookr app on one iPhone.\nThe Snookers Calculator\nThe Snookers tab is where you can check how many snookers are required when there is not enough points left on the table. It can be used with or without the scoreboard part of Snookr.\nThe Engineer\nSnookr is designed and developed by Yinan Qiu. Feel free to contact him if you have feedback, questions, or feature requests. Last but not least, he wishes you loads of ranking points, mate!\n\n"
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = SNKPadding.lineSpacingSmall
        paragraphStyle.alignment = .left
        paragraphStyle.paragraphSpacing = 20
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: UIFont.systemFont(ofSize: SNKFontSize.regular, weight: .regular),
            .foregroundColor: SNKColor.foregroundWhite
        ]
        let maString = NSMutableAttributedString(string: string, attributes: attributes)
        maString.addAttribute(.link, value: "https://yinan.design/contact", range: NSRange(location: 603, length: 11))
        let sectionTitleFont = UIFont.systemFont(ofSize: SNKFontSize.big, weight: SNKFontWeight.forFontSizeBig)
        maString.addAttribute(.font, value: sectionTitleFont, range: NSRange(location: 0, length: 14))
        maString.addAttribute(.font, value: sectionTitleFont, range: NSRange(location: 321, length: 24))
        maString.addAttribute(.font, value: sectionTitleFont, range: NSRange(location: 530, length: 12))
        bodyTextView.isEditable = false
        bodyTextView.linkTextAttributes = [NSAttributedString.Key.underlineStyle: true]
        bodyTextView.attributedText = maString
        bodyScrollView.translatesAutoresizingMaskIntoConstraints = false
        bodyScrollView.addSubview(bodyTextView)
        view.addSubviews(bodyScrollView, headerView, logoImageView)
        bodyScrollView.clipsToBounds = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.bottomAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: SNKPadding.big),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            logoImageView.leadingAnchor.constraint(equalTo: bodyScrollView.leadingAnchor),
            bodyScrollView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 35),
            bodyScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            bodyScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big),
            bodyScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -SNKPadding.big),
            bodyTextView.topAnchor.constraint(equalTo: bodyScrollView.topAnchor),
            bodyTextView.leadingAnchor.constraint(equalTo: bodyScrollView.leadingAnchor),
            bodyTextView.trailingAnchor.constraint(equalTo: bodyScrollView.trailingAnchor),
            bodyTextView.widthAnchor.constraint(equalTo: bodyScrollView.widthAnchor),
            bodyTextView.bottomAnchor.constraint(equalTo: bodyScrollView.bottomAnchor)
        ])
    }
    
}
