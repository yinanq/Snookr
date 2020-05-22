//
//  ScoreboardVC.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/9/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class ScoreboardVC: UIViewController {
    
    let notifCtr = NotificationCenter.default
    let defaults = UserDefaults.standard
    enum Key {
        static let player1sName = SNKCommonKeys.player1sName
        static let player2sName = SNKCommonKeys.player2sName
        static let player1sScore = "1's score"
        static let player2sScore = "2's score"
    }
    
    var player1 = Player(playerId: .player1)
    var player2 = Player(playerId: .player2)
    
    let separatorView = SNKSeparatorView()
    let stackView = ScoreboardStackView()
    let resetButton = ResetButton()
    let tapRecognizer = UITapGestureRecognizer()
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = SNKColor.background
        configureModels()
        configureViews()
        configureNotificationCenter()
        layoutViews()
        playLaunchScreenSmootherAnimation()
    }
    
    private func configureNotificationCenter() {
        notifCtr.addObserver(forName: .connectVcChangedNameOfPlayer1, object: nil, queue: nil) { notification in
            self.updateModelAndViewForName(of: &self.player1, to: notification.object as! String)
        }
        notifCtr.addObserver(forName: .framesVcChangedNameOfPlayer1, object: nil, queue: nil) { notification in
            self.updateModelAndViewForName(of: &self.player1, to: notification.object as! String)
        }
        notifCtr.addObserver(forName: .connectVcChangedNameOfPlayer2, object: nil, queue: nil) { notification in
            self.updateModelAndViewForName(of: &self.player2, to: notification.object as! String)
        }
        notifCtr.addObserver(forName: .framesVcChangedNameOfPlayer2, object: nil, queue: nil) { notification in
            self.updateModelAndViewForName(of: &self.player2, to: notification.object as! String)
        }
    }
    private func updateModelAndViewForName(of player: inout Player, to newName: String) {
        updatePlayerNameModel(player: &player, newName: newName)
        updatePlayerNameView(for: player)
    }
    
    private func matchNameFor(_ player: inout Player, newName: String) {
        switch player.playerId {
        case .player1:
            self.updatePlayerNameModel(player: &self.player1, newName: player.name)
            self.updatePlayerNameView(for: self.player1)
        case .player2:
            self.updatePlayerNameModel(player: &self.player2, newName: player.name)
            self.updatePlayerNameView(for: self.player2)
        case .unassigned: print("error: .unassigned playerId, in configureNotificationCenter")
        }
    }
    
    private func configureModels() {
        player1.name = defaults.string(forKey: Key.player1sName) ?? SNKNamePlaceholder.player1
        player2.name = defaults.string(forKey: Key.player2sName) ?? SNKNamePlaceholder.player2
        player1.score = defaults.integer(forKey: Key.player1sScore)
        player2.score = defaults.integer(forKey: Key.player2sScore)
    }
    
    private func configureViews() {
        stackView.scoreInfoView.playerNamesView.set(player1sName: player1.name, player2sName: player2.name)
        stackView.scoreInfoView.playerNamesView.textView1.delegate = self
        stackView.scoreInfoView.playerNamesView.textView2.delegate = self
        stackView.scoreInfoView.undoButtonsView.delegate = self
        stackView.scoreButtonsView.delegate = self
        updateScoresView()
        resetButton.delegate = self
        updateResetButton()
        view.addSubviews(separatorView, stackView, resetButton)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: SNKPadding.big),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big),
            stackView.bottomAnchor.constraint(equalTo: resetButton.topAnchor, constant: -SNKPadding.big),
            resetButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -SNKPadding.big),
            resetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            resetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big),
            separatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            separatorView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: SNKPadding.separatorViewTopAdj),
            separatorView.bottomAnchor.constraint(equalTo: resetButton.topAnchor, constant: -SNKPadding.big)
        ])
    }
    
}
