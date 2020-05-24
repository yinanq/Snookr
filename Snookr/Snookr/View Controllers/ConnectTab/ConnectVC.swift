//
//  ConnectVC.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/20/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ConnectVC: UIViewController {
    
    var mcState: SNKmcState = .notConnected
    
    var mcSession: MCSession?
    var mcAdvertiser: MCNearbyServiceAdvertiser?
    var mcBrowser: MCNearbyServiceBrowser?
    var mcPeerID: MCPeerID?
    var mcPeerIDDisplayName: String?
    let mcServiceType = "yinan-snookr"
    let notifCtr = NotificationCenter.default
    let defaults = UserDefaults.standard
    enum Key {
        static let player1sName = SNKCommonKey.player1sName
        static let player2sName = SNKCommonKey.player2sName
    }
    var player1 = Player(playerId: .player1)
    var player2 = Player(playerId: .player2)
    var opponentIs: SNKWhichPlayer = .player1
    let separatorView = SNKSeparatorView()
    let playerNamesView = SNKPlayerNamesView()
    let tapRecognizer = UITapGestureRecognizer()
    let containerView = SNKView()
    let meWhichPlayerView = MeWhichPlayerView()
    let connectButton = ConnectButton()
    
    //test stuff:
    let testPeerIDUserCode = "147"
    var testLabel: SNKLabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        configureModels()
        configureViews()
        configureNotifObservers()
        layoutViews()
        pseudoPersistMCState()
    }
    
    
    private func configureNotifObservers() {
        notifCtr.addObserver(forName: .scoreboardVCChangedNameOfPlayer1, object: nil, queue: nil) { notification in
            self.updateModelAndViewForName(of: &self.player1, to: notification.object as! String)
        }
        notifCtr.addObserver(forName: .framesVCChangedNameOfPlayer1, object: nil, queue: nil) { notification in
            self.updateModelAndViewForName(of: &self.player1, to: notification.object as! String)
        }
        notifCtr.addObserver(forName: .scoreboardVCChangedNameOfPlayer2, object: nil, queue: nil) { notification in
            self.updateModelAndViewForName(of: &self.player2, to: notification.object as! String)
        }
        notifCtr.addObserver(forName: .framesVCChangedNameOfPlayer2, object: nil, queue: nil) { notification in
            self.updateModelAndViewForName(of: &self.player2, to: notification.object as! String)
        }
    }
    private func updateModelAndViewForName(of player: inout Player, to newName: String) {
        updatePlayerNameModel(player: &player, newName: newName)
        updatePlayerNameView(for: player)
        if mcState == .isConnected { mcSend(snkDataTypeForMC: SNKDataTypeForMC.name, name: player.name) }
    }
    
    
    private func configureModels() {
        player1.name = defaults.string(forKey: Key.player1sName) ?? SNKNamePlaceholder.player1
        player2.name = defaults.string(forKey: Key.player2sName) ?? SNKNamePlaceholder.player2
        if let opponentIs = defaults.value(forKey: SNKCommonKey.opponentIsRawValue) as? Int {
            switch opponentIs {
            case SNKWhichPlayer.player1.rawValue: self.opponentIs = .player1
            case SNKWhichPlayer.player2.rawValue: self.opponentIs = .player2
            default: print("error: invalid case for opponentIs from persistence")
            }
        }
        mcGeneratePeerID()//tester code, see notes in definition
    }
    private func configureViews() {
        playerNamesView.set(player1sName: player1.name, player2sName: player2.name)
        playerNamesView.textView1.delegate = self
        playerNamesView.textView2.delegate = self
        switch opponentIs {
        case .player1: meWhichPlayerView.setOpponentToPlayer1()
        case .player2: meWhichPlayerView.setOpponentToPlayer2()
        }
        meWhichPlayerView.delegate = self
        connectButton.delegate = self
        //test stuff:
        testLabel = SNKLabel(fontSize: 100, fontWeight: .bold)
        testLabel.text = "0"
        //:test stuff
        containerView.addSubviews(meWhichPlayerView, connectButton, testLabel)
        view.addSubviews(separatorView, playerNamesView, containerView)
    }
    private func layoutViews() {
        NSLayoutConstraint.activate([
            separatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            separatorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: SNKPadding.big + SNKPadding.separatorViewTopAdj),
            separatorView.bottomAnchor.constraint(equalTo: playerNamesView.bottomAnchor, constant: SNKPadding.textViewAdjusterTop - 3.5),
            playerNamesView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: SNKPadding.big),
            playerNamesView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            playerNamesView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big),
            containerView.topAnchor.constraint(equalTo: playerNamesView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -SNKPadding.big),
            meWhichPlayerView.topAnchor.constraint(equalTo: containerView.topAnchor),
            meWhichPlayerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            meWhichPlayerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            connectButton.topAnchor.constraint(equalTo: testLabel.bottomAnchor, constant: SNKPadding.big),
            connectButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            connectButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            //test stuff:
            testLabel.topAnchor.constraint(equalTo: meWhichPlayerView.bottomAnchor, constant: 50),
            testLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])
    }
}
