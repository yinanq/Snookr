//
//  PointsAdderVC.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/13/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit
import AVFoundation

protocol PointsAdderVCDelegate: class { func didTapAddPointsButton(player: Player, pointsToAdd: Int) }

class PointsAdderVC: UIViewController {
    
    weak var delegate: PointsAdderVCDelegate!
    
    var player: Player!
    var points: Int?
    var pointsString = ""
    var headerView: PointsAdderHeaderView!
    var pointsLabel: SNKLabel!
    let numberPadView = PointsAdderNumberPadView()
    let cancelButton = SNKXButton()
    var addPointsButton: SNKButton!
    var soundPlayer: AVQueuePlayer?
    var soundOff: Bool!
    
    init(player: Player, delegate: PointsAdderVCDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.player = player
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureSoundSettings()
        numberPadView.delegate = self
    }
    
    private func configureSoundSettings() {
        soundOff = UserDefaults.standard.bool(forKey: SNKCommonKey.soundOff)
        NotificationCenter.default.addObserver(forName: .turnSoundOn, object: nil, queue: nil) { _ in
            self.soundOff = false
        }
        NotificationCenter.default.addObserver(forName: .turnSoundOff, object: nil, queue: nil) { _ in
            self.soundOff = true
        }
    }
    
    private func configure() {
        view.backgroundColor = SNKColor.background
        headerView = PointsAdderHeaderView(player: player)
        pointsLabel = SNKLabel(color: SNKColor.foregroundWhite, fontSize: SNKFontSize.gigantic, fontWeight: SNKFontWeight.forFontSizeGigantic, textAlignment: .center)
        pointsLabel.text = pointsString
        addPointsButton = SNKButton(title: "Add Points", style: .solid)
        addPointsButton.disableSolidStyleButton()
        view.addSubviews(headerView, pointsLabel, numberPadView, cancelButton, addPointsButton)
        [pointsLabel, numberPadView, addPointsButton].forEach { view in
            view?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: SNKPadding.big).isActive =  true
            view?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -SNKPadding.big).isActive = true
        }
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: SNKPadding.big),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            headerView.trailingAnchor.constraint(equalTo: view.centerXAnchor),
            cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: SNKPadding.big),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big+(SNKButtonSize.small-SNKButtonSize.smallerVisual)),
            pointsLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 32),
            pointsLabel.heightAnchor.constraint(equalToConstant: 100),
            numberPadView.topAnchor.constraint(equalTo: pointsLabel.bottomAnchor, constant: 30),
            numberPadView.bottomAnchor.constraint(equalTo: addPointsButton.topAnchor, constant: -45),
            addPointsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -SNKPadding.big)
        ])
        cancelButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        addPointsButton.addTarget(self, action: #selector(didTapAddPointsButton), for: .touchUpInside)
    }

    @objc func didTapCancelButton() { dismiss(animated: true) }
    @objc func didTapAddPointsButton() {
        guard let pointsToAdd = points else {
            print("error: didTapAddPointsButton when no pointsToAdd")
            return
        }
        if !soundOff { playSoundForTap(with: &soundPlayer) }
        delegate.didTapAddPointsButton(player: player, pointsToAdd: pointsToAdd)
        dismiss(animated: true)
    }

}
