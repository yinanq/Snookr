//
//  InfoVC.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/13/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class InfoVC: UIViewController {
    
    var titleLabel: SNKLabel!
    var bodyLabel: SNKLabel!
    var closeButton: SNKButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTitleLabel()
        configureBodyLabel()
        configureView()
        configureCloseButton()
        layout()
    }
    
    private func configureView() { view.backgroundColor = SNKColor.background }
    
    private func configureTitleLabel() {
        titleLabel = SNKLabel(fontSize: SNKFontSize.huge, fontWeight: SNKFontWeight.forFontSizeHuge, textAlignment: .center)
        titleLabel.text = "about"
        view.addSubview(titleLabel)
    }
    
    private func configureBodyLabel() {
        bodyLabel = SNKLabel(fontSize: SNKFontSize.regular, fontWeight: .regular, textAlignment: .left, numberOfLines: 0)
        bodyLabel.text =
        "Snookr, this app, is a scoreboard for snooker players. It is designed and developed by Yinan Qiu, a member at California Snooker. If you have any feedback or question, please feel free to contact him at https://yinan.design. He wishes you loads of ranking points, mate!"
        view.addSubview(bodyLabel)
    }
    
    private func configureCloseButton() {
        closeButton = SNKButton(title: "Back to Playing Snooker", style: .solid)
        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        view.addSubview(closeButton)
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: SNKPadding.big),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big),
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: SNKPadding.big),
            bodyLabel.widthAnchor.constraint(equalToConstant: 200),
            bodyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            closeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -SNKPadding.big),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big)
        ])
    }
    
    @objc func didTapCloseButton() {
        dismiss(animated: true)
    }
}
