//
//  FramesVC.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/18/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class FramesVC: UIViewController {
    
    let defaults = UserDefaults.standard
    
    enum Key {
        static let player1sName = "1's name"
        static let player2sName = "2's name"
        static let player1sFramesWon = "1's frames won"
        static let player2sFramesWon = "2's frames won"
    }
    
    var player1 = Player(playerId: .player1)
    var player2 = Player(playerId: .player2)
    
    let separatorView = SNKSeparatorView()
    let playerNamesView = PlayerNamesView()
    let framesWonView = FramesWonView()
    let framesWonButtonsView = FramesWonButtonsView()
    let resetButton = FramesResetButton()
    let tapRecognizer = UITapGestureRecognizer()
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = SNKColor.background
        view.addSubviews(separatorView, playerNamesView, framesWonView, framesWonButtonsView, resetButton)
        layout()
        configureDelegates()
        configureModels()
        configureViews()
    }
    
    private func configureDelegates() {
//        stackView.scoreInfoView.playerNamesView.textView1.delegate = self
//        stackView.scoreInfoView.playerNamesView.textView2.delegate = self
        framesWonButtonsView.delegate = self
        resetButton.delegate = self
    }
    
    private func configureModels() {
        if let player1SavedName = defaults.value(forKey: Key.player1sName) { player1.name = player1SavedName as! String }
        if let player2SavedName = defaults.value(forKey: Key.player2sName) { player2.name = player2SavedName as! String }
        if let player1SavedFramesWon = defaults.value(forKey: Key.player1sFramesWon) { player1.framesWon = player1SavedFramesWon as! Int }
        if let player2SavedFramesWon = defaults.value(forKey: Key.player2sFramesWon) { player2.framesWon = player2SavedFramesWon as! Int }
    }
    
    private func configureViews() {
        updatePlayerNamesView()
        updateFramesWonView()
        updateResetButton()
    }
    private func updatePlayerNamesView() { playerNamesView.set(player1sName: player1.name, player2sName: player2.name) }
    
    private func layout() {
        NSLayoutConstraint.activate([
            playerNamesView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: SNKPadding.big),
            playerNamesView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            playerNamesView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big),
            framesWonView.topAnchor.constraint(equalTo: playerNamesView.bottomAnchor, constant: SNKPadding.small),
            framesWonView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            framesWonView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big),
            framesWonButtonsView.topAnchor.constraint(equalTo: framesWonView.bottomAnchor, constant: SNKPadding.small),
            framesWonButtonsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            framesWonButtonsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big),
            resetButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -SNKPadding.big),
            resetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            resetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big),
            separatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            separatorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: SNKPadding.big + SNKPadding.separatorViewTopAdj),
            separatorView.bottomAnchor.constraint(equalTo: resetButton.topAnchor, constant: -SNKPadding.big)
        ])
    }
    
}
