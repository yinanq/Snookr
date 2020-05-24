//
//  ScoreboardVC.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/9/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class ScoreboardVC: UIViewController {
    
    var mcState: SNKmcState = .notConnected
    
    let notifCtr = NotificationCenter.default
    let defaults = UserDefaults.standard
    enum Key {
        static let player1sName = SNKCommonKey.player1sName
        static let player2sName = SNKCommonKey.player2sName
        static let player1sScore = "1's score"
        static let player2sScore = "2's score"
    }
    
    var player1 = Player(playerId: .player1)
    var player2 = Player(playerId: .player2)
    var opponentIs: SNKWhichPlayer = .player1
    let separatorView = SNKSeparatorView()
    let stackView = ScoreboardStackView()
    let resetButton = ResetButton()
    let tapRecognizer = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        view.backgroundColor = SNKColor.background
        configureModels()
        configureViews()
        configureNotifObservers()
        layoutViews()
        playLaunchScreenSmootherAnimation()
    }
    
    private func configureNotifObservers() {
        notifCtr.addObserver(forName: .connectVCChangedMCState, object: nil, queue: .main) { notification in
            self.mcState = notification.object as! SNKmcState
            self.updateViewsBasedOnMCState()
        }
        notifCtr.addObserver(forName: .connectVCChangedWhoswho, object: nil, queue: nil) { notification in
            self.opponentIs = notification.object as! SNKWhichPlayer
        }
        notifCtr.addObserver(forName: .connectVCChangedNameOfPlayer1, object: nil, queue: nil) { notification in
            self.updateModelAndViewForName(of: &self.player1, to: notification.object as! String)
        }
        notifCtr.addObserver(forName: .framesVCChangedNameOfPlayer1, object: nil, queue: nil) { notification in
            self.updateModelAndViewForName(of: &self.player1, to: notification.object as! String)
        }
        notifCtr.addObserver(forName: .connectVCChangedNameOfPlayer2, object: nil, queue: nil) { notification in
            self.updateModelAndViewForName(of: &self.player2, to: notification.object as! String)
        }
        notifCtr.addObserver(forName: .framesVCChangedNameOfPlayer2, object: nil, queue: nil) { notification in
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
        player1.score = defaults.integer(forKey: Key.player1sScore)
        player2.score = defaults.integer(forKey: Key.player2sScore)
        if let mcStateB4ThisTabFirstOpen = defaults.value(forKey: SNKCommonKey.mcStateRawValue) as? Int {
            switch mcStateB4ThisTabFirstOpen {
            case SNKmcState.notConnected.rawValue: mcState = .notConnected
            case SNKmcState.isConnected.rawValue: mcState = .isConnected
            case SNKmcState.isConnecting.rawValue: mcState = .isConnecting
            default: print("error: invalid case for mcStateB4ThisTabFirstOpen")
            }
        } else { print("error: no mcStateB4ThisTabFirstOpen")}
        if let opponentIs = defaults.value(forKey: SNKCommonKey.opponentIsRawValue) as? Int {
            switch opponentIs {
            case SNKWhichPlayer.player1.rawValue: self.opponentIs = .player1
            case SNKWhichPlayer.player2.rawValue: self.opponentIs = .player2
            default: print("error: invalid case for opponentIs from persistence")
            }
        }
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
        updateViewsBasedOnMCState()
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
