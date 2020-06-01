//
//  ScoreboardVC.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/9/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class ScoreboardVC: UIViewController {
    
    var cbState: SNKcbState = .notConnected
    let notifCtr = NotificationCenter.default
    let defaults = UserDefaults.standard
    var player1 = Player(playerId: .player1)
    var player2 = Player(playerId: .player2)
    var opponentIs: SNKWhichPlayer = .player1
    var currentWinnerIs: SNKWhichPlayer?
    let separatorView = SNKSeparatorView()
    let stackView = ScoreboardStackView()
    let resetButton = ResetButton()
//    let winButton1 = WinButton()
//    let winButton2 = WinButton()
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
        //cb opponent score:
        notifCtr.addObserver(forName: .connectVCReceivedUpdatedScore, object: nil, queue: .main) { notification in
            let data = notification.object as! SNKcbData
            self.cbUpdateOpponentScoreToReceived(data)
            self.updateResetButton()
        }
        notifCtr.addObserver(forName: .connectVCReceivedResetScores, object: nil, queue: .main) { notification in
            self.resetScores()
            //to add indicator showing it was reset by opponent via bluetooth
        }
        //cb connection state:
        notifCtr.addObserver(forName: .connectVCChangedCBState, object: nil, queue: .main) { notification in
            self.cbState = notification.object as! SNKcbState
            self.cbUpdateForState()
        }
        //opponentIs:
        notifCtr.addObserver(forName: .connectVCChangedWhoswho, object: nil, queue: nil) { notification in
            self.opponentIs = notification.object as! SNKWhichPlayer
        }
        //name:
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
        player1.name = defaults.string(forKey: SNKCommonKey.player1sName) ?? SNKNamePlaceholder.player1
        player2.name = defaults.string(forKey: SNKCommonKey.player2sName) ?? SNKNamePlaceholder.player2
        player1.score = defaults.integer(forKey: SNKCommonKey.player1sScore)
        player2.score = defaults.integer(forKey: SNKCommonKey.player2sScore)
        if let cbStateB4ThisTabFirstOpen = defaults.value(forKey: SNKCommonKey.cbStateRawValue) as? Int {
            switch cbStateB4ThisTabFirstOpen {
            case SNKcbState.notConnected.rawValue: cbState = .notConnected
            case SNKcbState.isConnected.rawValue: cbState = .isConnected
            case SNKcbState.isConnecting.rawValue: cbState = .isConnecting
            default: print("error: invalid case for cbStateB4ThisTabFirstOpen")
            }
        } else { print("error: no cbStateB4ThisTabFirstOpen")}
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
//        winButton1.delegate = self
//        winButton2.delegate = self
//        winButton1.tag = 1
//        winButton2.tag = 2
//        view.addSubviews(separatorView, stackView, resetButton, winButton1, winButton2)
        view.addSubviews(separatorView, stackView, resetButton)
        cbUpdateForState()
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
//            resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            winButton1.bottomAnchor.constraint(equalTo: resetButton.bottomAnchor),
//            winButton2.bottomAnchor.constraint(equalTo: resetButton.bottomAnchor),
//            winButton1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
//            winButton1.trailingAnchor.constraint(equalTo: resetButton.leadingAnchor, constant: -SNKPadding.small),
//            winButton2.leadingAnchor.constraint(equalTo: resetButton.trailingAnchor, constant: SNKPadding.small),
//            winButton2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big),
            separatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            separatorView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: SNKPadding.separatorViewTopAdj),
            separatorView.bottomAnchor.constraint(equalTo: resetButton.topAnchor, constant: -SNKPadding.big)
        ])
    }
}
