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
    var bodyTextViewContainerView = UIView()
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
        let string = "Snookr is a snooker scoreboard and a calculator of how many snookers are required. You and your opponent at the snooker table can each use your own Snookr app on your own iPhone in the Bluetooth-connected mode. You can also choose not to turn on Bluetooth connection and just update both players' scores on one iPhone.\nSnookr is designed and developed by Yinan Qiu. Feel free to contact him if you have feedback, questions, or feature requests. Last but not least, he wishes you loads of ranking points, mate!"
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
        maString.addAttribute(.link, value: "https://yinan.design/contact", range: NSRange(location: 379, length: 11))
        bodyTextView.isEditable = false
        bodyTextView.linkTextAttributes = [NSAttributedString.Key.underlineStyle: true]
        bodyTextView.attributedText = maString
        bodyTextViewContainerView.translatesAutoresizingMaskIntoConstraints = false
        bodyTextViewContainerView.addSubview(bodyTextView)
        view.addSubview(bodyTextViewContainerView)
    }
    
    @objc func didTapCloseButton() { dismiss(animated: true) }
    
    private func layout() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            logoImageView.leadingAnchor.constraint(equalTo: bodyTextViewContainerView.leadingAnchor),
            bodyTextViewContainerView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 30),
            bodyTextViewContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            bodyTextViewContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big),
            bodyTextView.topAnchor.constraint(equalTo: bodyTextViewContainerView.topAnchor),
            bodyTextView.leadingAnchor.constraint(equalTo: bodyTextViewContainerView.leadingAnchor),
            bodyTextView.trailingAnchor.constraint(equalTo: bodyTextViewContainerView.trailingAnchor),
            bodyTextView.bottomAnchor.constraint(equalTo: bodyTextViewContainerView.bottomAnchor),
        ])
    }
    
}
