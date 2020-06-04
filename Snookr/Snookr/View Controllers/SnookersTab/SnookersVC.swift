//
//  SnookersVC.swift
//  Snookr
//
//  Created by Yinan Qiu on 6/2/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class SnookersVC: UIViewController {
    
    let stackView = UIStackView()
    let titleVC = SnookersTitleVC()
    let difVC = SnookersDifVC()
    let ballsVC = SnookersBallsVC()
    let tapRecognizer = UITapGestureRecognizer()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
        configureChildren()
    }
    
    private func configureSelf() {
        overrideUserInterfaceStyle = .dark
        view.backgroundColor = SNKColor.background
    }
    
    private func configureChildren() {
        addAndConfigureChildVCSkipView(titleVC)
        difVC.delegate = self
        addAndConfigureChildVCSkipView(difVC)
        addAndConfigureChildVCSkipView(ballsVC)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubviews(titleVC.view, difVC.view, ballsVC.view)
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -SNKPadding.big),
        ])
    }

}
