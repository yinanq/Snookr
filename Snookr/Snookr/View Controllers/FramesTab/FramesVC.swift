//
//  FramesVC.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/18/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class FramesVC: UIViewController {
    
    var cbState: SNKcbState = .notConnected
    let notifCtr = NotificationCenter.default
    let defaults = UserDefaults.standard
    var player1 = Player(playerId: .player1)
    var player2 = Player(playerId: .player2)
    var opponentIs: SNKWhichPlayer = .player1
    let separatorView = SNKSeparatorView()
    let playerNamesView = SNKPlayerNamesView()
    let framesWonView = FramesWonView()
    let framesWonButtonsView = FramesWonButtonsView()
    let resetButton = FramesResetButton()
//    let connectedStatusView = SNKConnectedStatusView()
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
        //cb opponent frame:
        notifCtr.addObserver(forName: .connectVCReceivedUpdatedFrame, object: nil, queue: .main) { notification in
            let updatedFrame = notification.object as! Int
            switch self.opponentIs {
            case .player1:
                self.updateFramesWonModel(of: &self.player1, to: updatedFrame)
                self.updateFramesWonView(of: &self.player1)
                self.persistFramesWon(of: &self.player1)
            case .player2:
                self.updateFramesWonModel(of: &self.player2, to: updatedFrame)
                self.updateFramesWonView(of: &self.player2)
                self.persistFramesWon(of: &self.player2)
            }
            self.updateResetButton()
        }
        notifCtr.addObserver(forName: .connectVCReceivedResetFrames, object: nil, queue: .main) { _ in
            self.cbOpponentDidTapConfirmToReset()
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
        notifCtr.addObserver(forName: .connectVCChangedNameOfPlayer2, object: nil, queue: nil) { notification in
            self.updateModelAndViewForName(of: &self.player2, to: notification.object as! String)
        }
        notifCtr.addObserver(forName: .scoreboardVCChangedNameOfPlayer1, object: nil, queue: nil) { notification in
            self.updateModelAndViewForName(of: &self.player1, to: notification.object as! String)
        }
        notifCtr.addObserver(forName: .scoreboardVCChangedNameOfPlayer2, object: nil, queue: nil) { notification in
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
        player1.framesWon = defaults.integer(forKey: SNKCommonKey.player1sFrame)
        player2.framesWon = defaults.integer(forKey: SNKCommonKey.player2sFrame)
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
        playerNamesView.textView1.delegate = self
        playerNamesView.textView2.delegate = self
        updatePlayerNamesView()
        framesWonButtonsView.delegate = self
        updateFramesWonView()
        resetButton.delegate = self
        updateResetButton()
        view.addSubviews(separatorView, playerNamesView, framesWonView, framesWonButtonsView, resetButton)
        cbUpdateForState()
    }
    private func updatePlayerNamesView() { playerNamesView.set(player1sName: player1.name, player2sName: player2.name) }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
//            connectedStatusView.topAnchor.constraint(equalTo: view.topAnchor),
//            connectedStatusView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            connectedStatusView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            connectedStatusView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -SNKPadding.tiny),
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
            separatorView.bottomAnchor.constraint(equalTo: resetButton.topAnchor, constant: -SNKPadding.big),
        ])
    }
    
}
