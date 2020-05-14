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
        view.backgroundColor = SNKColor.background
        
        addPointsButton = SNKButton(title: "Add Points", style: .solid)
        view.addSubview(addPointsButton)
        NSLayoutConstraint.activate([
            addPointsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -SNKPadding.big),
            addPointsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            addPointsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big)
        ])
        addPointsButton.addTarget(self, action: #selector(didTapAddPointsButton), for: .touchUpInside)
    }

    @objc func didTapAddPointsButton() {
        dismiss(animated: true)
    }

}
