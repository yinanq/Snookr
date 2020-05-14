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
    
    var headerView: PointsAdderHeaderView!
    var pointsLabel: SNKLabel!
    let numberPadView = PointsAdderNumberPadView()
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
        headerView = PointsAdderHeaderView(player: player)
        pointsLabel = SNKLabel(fontSize: SNKFontSize.huge, fontWeight: .medium, textAlignment: .center)
        pointsLabel.text = "147"
        cancelButton = SNKButton(title: "Cancel", style: .naked)
        addPointsButton = SNKButton(title: "Add Points", style: .solid)
        view.addSubviews(headerView, pointsLabel, numberPadView, cancelButton, addPointsButton)
        [headerView, pointsLabel, numberPadView, addPointsButton].forEach { view in
            view?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: SNKPadding.big).isActive =  true
            view?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -SNKPadding.big).isActive = true
//            view?.backgroundColor = SNKColor.backgroundSecondary
        }
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 36),
            pointsLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 24),
            pointsLabel.heightAnchor.constraint(equalToConstant: 80),
            numberPadView.topAnchor.constraint(equalTo: pointsLabel.bottomAnchor, constant: 26),
            numberPadView.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -34),
            cancelButton.bottomAnchor.constraint(equalTo: addPointsButton.topAnchor, constant: -12),
            cancelButton.widthAnchor.constraint(equalToConstant: 100),
            cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addPointsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -SNKPadding.big)
        ])
        cancelButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        addPointsButton.addTarget(self, action: #selector(didTapAddPointsButton), for: .touchUpInside)
    }

    @objc func didTapCancelButton() { dismiss(animated: true) }
    @objc func didTapAddPointsButton() {
        dismiss(animated: true)
    }

}
