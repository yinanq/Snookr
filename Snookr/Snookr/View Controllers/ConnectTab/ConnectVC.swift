//
//  ConnectVC.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/20/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit
import CoreBluetooth

class ConnectVC: UIViewController {
    
    //Core Bluetooth properties:
    //cb shared identifiers:
    let cbSnookrUUID = CBUUID(string: "4E33A1D9-9FE0-46FB-B3C9-3604A5A0D05A")//a different key is used in production app
    var cbUserDefinedLocalName: String!
    let cbSnookrServiceUUID = CBUUID(string: "B78716C9-29E0-4EDB-9219-9E69F9414C87")//a different key is used in production app
    let cbSnookrCharacteristicUUID = CBUUID(string: "B6F15CF2-A726-462D-8A07-257956821E6E")//a different key is used in production app
    //cb central side:
    var cbCentralManager: CBCentralManager!
    var cbChosenPeripheral: CBPeripheral!
    var cbChosenCharacteristic: CBCharacteristic!
    //cb peripheral side:
    var cbPeripheralManager: CBPeripheralManager!
    //cb state markers:
    var cbState: SNKcbState = .notConnected
    var cbStateCentral: SNKcbState = .notConnected
    var cbStatePeripheral: SNKcbState = .notConnected
    //Core Bluetooth properties END
    let notifCtr = NotificationCenter.default
    let defaults = UserDefaults.standard
    var player1 = Player(playerId: .player1)
    var player2 = Player(playerId: .player2)
    var opponentIs: SNKWhichPlayer = .player1
    let separatorView = SNKSeparatorView()
    let playerNamesView = SNKPlayerNamesView()
    let tapRecognizer = UITapGestureRecognizer()
    let containerView = SNKView()
    let meWhichPlayerView = MeWhichPlayerView()
    let connectCodeTextField = ConnectCodeTextField()
    let connectInstructionTextView = ConnectInstructionTextView()
    let connectButton = ConnectButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        configureModels()
        configureViews()
        configureNotifObservers()
        layoutViews()
        pseudoPersistCBState()
    }
    
    
    private func configureNotifObservers() {
        //score:
        notifCtr.addObserver(forName: .scoreboardVCChangedScoreOfEitherPlayer, object: nil, queue: nil) { notification in
            let data = notification.object as! SNKcbData
            if self.cbState == .isConnected { self.cbSend(data) }
        }
        notifCtr.addObserver(forName: .scoreboardVCDidResetScores, object: nil, queue: nil) { notification in
            if self.cbState == .isConnected { self.cbSend(snkCBDataType: SNKcbDataType.resetScore)}
        }
        //frame:
        notifCtr.addObserver(forName: .framesVCChangedFramesOfEitherPlayer, object: nil, queue: nil) { notification in
            if self.cbState == .isConnected { self.cbSend(snkCBDataType: SNKcbDataType.frame, frame: notification.object as? Int) }
        }
        notifCtr.addObserver(forName: .framesVCDidResetFrames, object: nil, queue: nil) { _ in
            if self.cbState == .isConnected { self.cbSend(snkCBDataType: SNKcbDataType.resetFrame) }
        }
        //player name:
        notifCtr.addObserver(forName: .scoreboardVCChangedNameOfPlayer1, object: nil, queue: nil) { notification in
            self.updateAndMaybeCBSendName(of: &self.player1, to: notification.object as! String)
        }
        notifCtr.addObserver(forName: .scoreboardVCChangedNameOfPlayer2, object: nil, queue: nil) { notification in
            self.updateAndMaybeCBSendName(of: &self.player2, to: notification.object as! String)
        }
        notifCtr.addObserver(forName: .framesVCChangedNameOfPlayer1, object: nil, queue: nil) { notification in
            self.updateAndMaybeCBSendName(of: &self.player1, to: notification.object as! String)
        }
        notifCtr.addObserver(forName: .framesVCChangedNameOfPlayer2, object: nil, queue: nil) { notification in
            self.updateAndMaybeCBSendName(of: &self.player2, to: notification.object as! String)
        }
    }
    private func updateAndMaybeCBSendName(of player: inout Player, to newName: String) {
        updatePlayerNameModel(player: &player, newName: newName)
        updatePlayerNameView(for: player)
        if cbState == .isConnected { cbSend(snkCBDataType: SNKcbDataType.playerName, playerName: player.name)}
    }
    
    
    private func configureModels() {
        player1.name = defaults.string(forKey: SNKCommonKey.player1sName) ?? SNKNamePlaceholder.player1
        player2.name = defaults.string(forKey: SNKCommonKey.player2sName) ?? SNKNamePlaceholder.player2
        if let opponentIs = defaults.value(forKey: SNKCommonKey.opponentIsRawValue) as? Int {
            switch opponentIs {
            case SNKWhichPlayer.player1.rawValue: self.opponentIs = .player1
            case SNKWhichPlayer.player2.rawValue: self.opponentIs = .player2
            default: print("error: invalid case for opponentIs from persistence")
            }
        }
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
        connectCodeTextField.delegate = self
        connectCodeTextField.snkDelegate = self
        connectButton.delegate = self
        containerView.addSubviews(meWhichPlayerView, connectInstructionTextView, connectCodeTextField, connectButton)
        view.addSubviews(separatorView, playerNamesView, containerView)
    }
    @objc func didTapTesetButton() {
        guard let data = "hahaha147".data(using: .utf8) else { return }
        guard let peripheral = cbChosenPeripheral else { return }
        guard let characteristic = cbChosenCharacteristic else { return }
        peripheral.writeValue(data, for: characteristic, type: .withResponse)
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
            connectCodeTextField.bottomAnchor.constraint(equalTo: connectInstructionTextView.topAnchor),
            connectCodeTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            connectInstructionTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            connectInstructionTextView.bottomAnchor.constraint(equalTo: connectButton.topAnchor),
            connectButton.topAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 25),
            connectButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            connectButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
        ])
    }
}
