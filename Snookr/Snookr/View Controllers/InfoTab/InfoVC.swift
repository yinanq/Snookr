//
//  InfoVC.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/13/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class InfoVC: UIViewController {
    
    let logoImageView = UIImageView()
    var bodyScrollView = UIScrollView()
    var bodyTextView = SNKTextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        view.backgroundColor = SNKColor.background
        configureTitle()
        configureBodyTextViewContainerView()
        layout()
    }
    
    private func configureTitle() {
        logoImageView.image = UIImage(named: "logo-green")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImageView)
    }
    
    private func configureBodyTextViewContainerView() {
        let string = "The Scoreboard\nTo get the most out of this scoreboard, you and your opponent at the snooker table can each use your own Snookr app on your own iPhone in the Bluetooth-connected mode. Of course, you can also choose not to turn on Bluetooth connection and just update both players' scores from one Snookr app on one iPhone.\nThe Snookers Calculator\nThe Snookers tab is where you can check how many snookers are required when there is not enough points left on the table. It can be used with or without the scoreboard part of Snookr.\nThe Author\nSnookr is designed and developed by Yinan Qiu. Feel free to contact him if you have feedback, questions, or feature requests. Last but not least, he wishes you loads of ranking points, mate!"
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = SNKPadding.lineSpacing
        paragraphStyle.alignment = .left
        paragraphStyle.paragraphSpacing = 20
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: UIFont.systemFont(ofSize: SNKFontSize.regular, weight: SNKFontWeight.forFontSizeRegular),
            .foregroundColor: SNKColor.foregroundGray,
        ]
        let maString = NSMutableAttributedString(string: string, attributes: attributes)
        maString.addAttribute(.link, value: "https://yinan.design/contact", range: NSRange(location: 601, length: 11))
        bodyTextView.isEditable = false
        bodyTextView.linkTextAttributes = [NSAttributedString.Key.underlineStyle: true]
        bodyTextView.attributedText = maString
        bodyScrollView.translatesAutoresizingMaskIntoConstraints = false
//        bodyScrollView.
        bodyScrollView.addSubview(bodyTextView)
        view.addSubviews(logoImageView, bodyScrollView)
    }
    
    @objc func didTapCloseButton() { dismiss(animated: true) }
    
    private func layout() {
        NSLayoutConstraint.activate([
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
