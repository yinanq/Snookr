//
//  InfoVC.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/13/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class InfoVC: UIViewController {
    
    var closeButton: SNKButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = SNKColor.background
        
        closeButton = SNKButton(title: "OK", style: .solid)
        view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -SNKPadding.big),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big)
        ])
        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
    }

    @objc func didTapCloseButton() {
        dismiss(animated: true)
    }
    
}
