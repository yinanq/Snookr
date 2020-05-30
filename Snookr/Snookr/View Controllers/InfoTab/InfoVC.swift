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
//        print("info tab")
    }
    
    private func configureTitle() {
        logoImageView.image = UIImage(named: "logo-green")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImageView)
    }
    
    private func configureBodyTextViewContainerView() {
        let string = "Snookr is a scoreboard for the cue sport snooker. It's designed and developed by Yinan Qiu. Feel free to contact him if you have feedback, questions, or feature requests. Last but not least, he wishes you loads of ranking points, mate!"
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = SNKPadding.lineSpacing
        paragraphStyle.alignment = .left
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: UIFont.systemFont(ofSize: SNKFontSize.regular, weight: SNKFontWeight.forFontSizeRegular),
            .foregroundColor: SNKColor.foreground,
        ]
        let maString = NSMutableAttributedString(string: string, attributes: attributes)
        maString.addAttribute(.link, value: "https://yinan.design/contact", range: NSRange(location: 105, length: 11))
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
            logoImageView.leadingAnchor.constraint(equalTo: bodyTextViewContainerView.leadingAnchor, constant: 5),
            bodyTextViewContainerView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 40),
            bodyTextViewContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big + -SNKPadding.textViewAdjusterBodyText),
            bodyTextViewContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big + SNKPadding.textViewAdjusterBodyText),
            bodyTextView.topAnchor.constraint(equalTo: bodyTextViewContainerView.topAnchor),
            bodyTextView.leadingAnchor.constraint(equalTo: bodyTextViewContainerView.leadingAnchor),
            bodyTextView.trailingAnchor.constraint(equalTo: bodyTextViewContainerView.trailingAnchor),
            bodyTextView.bottomAnchor.constraint(equalTo: bodyTextViewContainerView.bottomAnchor),
        ])
    }
    
}
