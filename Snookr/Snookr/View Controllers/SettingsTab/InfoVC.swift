//
//  InfoVC.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/13/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class InfoVC: UIViewController {
    
    var scrollView = UIScrollView()
    var contentTextView = SNKTextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        view.backgroundColor = SNKColor.background
        title = "About"
        navigationController?.navigationBar.tintColor = SNKColor.foreground
        configureChildViews()
    }
    
    private func configureChildViews() {
        let string = "The Scoreboard\nThe scoreboard can be used by two snooker players when they play a match. In the Bluetooth-connected mode, scores auto sync between two Snookr apps. You and your opponent can each update from your own app. When not connected, it works as a standalone scoreboard where both players' scores can be updated on one iPhone.\nThe Snookers Calculator\nThe Snookers tab is where you can check how many snookers are required when there is not enough points left on the table. It can be used with or without the scoreboard part of Snookr.\nThe Engineer\nSnookr is designed and developed by Yinan Qiu. Feel free to contact him if you have feedback, questions, or feature requests. Last but not least, he wishes you loads of ranking points, mate!"
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
        maString.addAttribute(.link, value: "https://yinan.design/contact", range: NSRange(location: 615, length: 11))
        let sectionTitleFont = UIFont.systemFont(ofSize: SNKFontSize.big, weight: SNKFontWeight.forFontSizeBig)
        maString.addAttribute(.font, value: sectionTitleFont, range: NSRange(location: 0, length: 14))
        maString.addAttribute(.font, value: sectionTitleFont, range: NSRange(location: 333, length: 24))
        maString.addAttribute(.font, value: sectionTitleFont, range: NSRange(location: 542, length: 12))
        contentTextView.linkTextAttributes = [NSAttributedString.Key.underlineStyle: true]
        contentTextView.attributedText = maString
        contentTextView.isEditable = false
        scrollView.addSubview(contentTextView)
        scrollView.frame = view.bounds
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            contentTextView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: SNKPadding.big),
            contentTextView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: SNKPadding.big),
            contentTextView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -SNKPadding.big),
            contentTextView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -2*SNKPadding.big),
            contentTextView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -SNKPadding.huge)
        ])
    }
    
}
