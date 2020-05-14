//
//  PointsAdderVC.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/13/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

protocol PointsAdderVCDelegate: class {
    func didTapAddPointsButton()
}

import UIKit

class PointsAdderVC: UIViewController {
    
    weak var delegate: PointsAdderVCDelegate!
    
    var player: Player!
    
    var cancelButton: SNKButton!
    var addPointsButton: SNKButton!
    
    init(player: Player) {
        super.init(nibName: nil, bundle: nil)
        self.player = player
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        view.backgroundColor = SNKColor.background
        cancelButton = SNKButton(title: "Cancel", style: .naked)
        addPointsButton = SNKButton(title: "Add Points", style: .solid)
        view.addSubviews(cancelButton, addPointsButton)
        NSLayoutConstraint.activate([
            addPointsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -SNKPadding.big),
            addPointsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            addPointsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big),
            cancelButton.bottomAnchor.constraint(equalTo: addPointsButton.topAnchor, constant: -SNKPadding.big),
            cancelButton.widthAnchor.constraint(equalToConstant: 100),
            cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        cancelButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        addPointsButton.addTarget(self, action: #selector(didTapAddPointsButton), for: .touchUpInside)
    }

    @objc func didTapCancelButton() { dismiss(animated: true) }
    @objc func didTapAddPointsButton() {
        dismiss(animated: true)
    }

}
