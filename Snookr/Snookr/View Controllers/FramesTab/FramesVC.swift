//
//  FramesVC.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/18/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class FramesVC: UIViewController {
        
    let notifCtr = NotificationCenter.default
    let defaults = UserDefaults.standard
    enum Key {
        static let player1sName = SNKCommonKeys.player1sName
        static let player2sName = SNKCommonKeys.player2sName
        static let player1sFramesWon = "1's frames won"
        static let player2sFramesWon = "2's frames won"
    }
    
    var player1 = Player(playerId: .player1)
    var player2 = Player(playerId: .player2)
    
    let separatorView = SNKSeparatorView()
    let playerNamesView = SNKPlayerNamesView()
    let framesWonView = FramesWonView()
    let framesWonButtonsView = FramesWonButtonsView()
    let resetButton = FramesResetButton()
    let tapRecognizer = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        view.backgroundColor = SNKColor.background
        configureModels()
        configureViews()
        configureNotifObservers()
        layoutViews()
    }
    
    private func configureNotifObservers() {
        notifCtr.addObserver(forName: .connectVcChangedNameOfPlayer1, object: nil, queue: nil) { notification in
            self.updateModelAndViewForName(of: &self.player1, to: notification.object as! String)
        }
        notifCtr.addObserver(forName: .scoreboardVcChangedNameOfPlayer1, object: nil, queue: nil) { notification in
            self.updateModelAndViewForName(of: &self.player1, to: notification.object as! String)
        }
        notifCtr.addObserver(forName: .connectVcChangedNameOfPlayer2, object: nil, queue: nil) { notification in
            self.updateModelAndViewForName(of: &self.player2, to: notification.object as! String)
        }
        notifCtr.addObserver(forName: .scoreboardVcChangedNameOfPlayer2, object: nil, queue: nil) { notification in
            self.updateModelAndViewForName(of: &self.player2, to: notification.object as! String)
        }
    }
    private func updateModelAndViewForName(of player: inout Player, to newName: String) {
        updatePlayerNameModel(player: &player, newName: newName)
        updatePlayerNameView(for: player)
    }
    
    private func configureModels() {
        player1.name = defaults.string(forKey: Key.player1sName) ?? SNKNamePlaceholder.player1
        player2.name = defaults.string(forKey: Key.player2sName) ?? SNKNamePlaceholder.player2
        player1.framesWon = defaults.integer(forKey: Key.player1sFramesWon)
        player2.framesWon = defaults.integer(forKey: Key.player2sFramesWon)
    }
    
    private func configureViews() {
        playerNamesView.textView1.delegate = self
        playerNamesView.textView2.delegate = self
        updatePlayerNamesView()
        framesWonButtonsView.delegate = self
        updateFramesWonView()
        resetButton.delegate = self
        updateResetButton()
        view.addSubviews(separatorView, playerNamesView, framesWonView, framesWonButtonsView, resetButton)
    }
    private func updatePlayerNamesView() { playerNamesView.set(player1sName: player1.name, player2sName: player2.name) }
    
    private func layoutViews() {
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
