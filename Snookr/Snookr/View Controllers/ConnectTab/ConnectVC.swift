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
    
    let mcPeerID = MCPeerID(displayName: UIDevice.current.name) //temp
    var mcSession: MCSession?
    var mcAdvertiser: MCNearbyServiceAdvertiser?
    
    let notifCtr = NotificationCenter.default
    let defaults = UserDefaults.standard
    enum Key {
        static let player1sName = SNKCommonKeys.player1sName
        static let player2sName = SNKCommonKeys.player2sName
    }
    
    var player1 = Player(playerId: .player1)
    var player2 = Player(playerId: .player2)
    var userIsPlayer2 = true
    
    let separatorView = SNKSeparatorView()
    let playerNamesView = SNKPlayerNamesView()
    let containerView = SNKView()
    let meWhichPlayerView = MeWhichPlayerView()
    var testLabel: SNKLabel!
    let connectButton = SNKButton()
    let testBtn1 = SNKButton()
    let testBtn2 = SNKButton()
    let tapRecognizer = UITapGestureRecognizer()
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        configureMC()
        configureViews()
        configureNotifObservers()
        layoutViews()
    }
    
    private func configureMC() {
        mcSession = MCSession(peer: mcPeerID, securityIdentity: nil, encryptionPreference: .required)
        mcSession?.delegate = self
    }
    
    func hostSession(_: UIAlertAction) {
        mcAdvertiser = MCNearbyServiceAdvertiser(peer: mcPeerID, discoveryInfo: nil, serviceType: SNKmcServiceType)
        mcAdvertiser?.delegate = self
        mcAdvertiser?.startAdvertisingPeer()
    }
    
    func joinSession(_: UIAlertAction) {
        guard let mcSession = mcSession else { return }
        let mcBrowserVC = MCBrowserViewController(serviceType: SNKmcServiceType, session: mcSession)
        mcBrowserVC.delegate = self
        present(mcBrowserVC, animated: true)
//        let mcBrowser = MCNearbyServiceBrowser(peer: mcPeerID, serviceType: SNKmcServiceType)
//        mcBrowser.delegate = self
//        mcBrowser.startBrowsingForPeers()
    }
    
    @objc func didTapConnectButton() {
        let ac = UIAlertController(title: "Connect with Opponent", message: "temp message", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "temp host session", style: .default, handler: hostSession)) //temp
        ac.addAction(UIAlertAction(title: "temp join session", style: .default, handler: joinSession)) //temp
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.view.tintColor = SNKColor.foreground
        present(ac, animated: true)
    }
    
    @objc func testTap(sender: SNKButton) {
        testLabel.text = "\(sender.tag)"
        syncConnectedOpponent(testBtnTag: sender.tag)
    }
    private func syncConnectedOpponent(testBtnTag: Int) {
        guard let mcSession = mcSession else { return }
        if mcSession.connectedPeers.count > 0 {
            if let testData = String(testBtnTag).data(using: .utf8) {
                do {
                    try mcSession.send(testData, toPeers: mcSession.connectedPeers, with: .reliable)
                } catch {
                    print("error in syncConnectedOpponent: \(error.localizedDescription)")
                    let ac = UIAlertController(title: "Connection Lost", message: "Connection with your opponent has been lost.", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    ac.view.tintColor = SNKColor.foreground
                    present(ac, animated: true)
                }
            }
        }
    }
    
    
    
    
    
    
    private func configureNotifObservers() {
        notifCtr.addObserver(forName: .scoreboardVcChangedNameOfPlayer1, object: nil, queue: nil) { notification in
            self.updateModelAndViewForName(of: &self.player1, to: notification.object as! String)
        }
        notifCtr.addObserver(forName: .framesVcChangedNameOfPlayer1, object: nil, queue: nil) { notification in
            self.updateModelAndViewForName(of: &self.player1, to: notification.object as! String)
        }
        notifCtr.addObserver(forName: .scoreboardVcChangedNameOfPlayer2, object: nil, queue: nil) { notification in
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
    
    private func configureModels() {
        player1.name = defaults.string(forKey: Key.player1sName) ?? SNKNamePlaceholder.player1
        player2.name = defaults.string(forKey: Key.player2sName) ?? SNKNamePlaceholder.player2
    }
    
    private func configureViews() {
        playerNamesView.set(player1sName: player1.name, player2sName: player2.name)
        playerNamesView.textView1.delegate = self
        playerNamesView.textView2.delegate = self
        view.addSubviews(separatorView, playerNamesView, containerView)
        //test stuff:
        connectButton.set(title: "Connect with Opponent", style: .solid)
        connectButton.addTarget(self, action: #selector(didTapConnectButton), for: .touchUpInside)
        testLabel = SNKLabel(fontSize: 100, fontWeight: .bold)
        testLabel.text = "0"
        testBtn1.set(title: "test 1", style: .solid)
        testBtn2.set(title: "test 2", style: .solid)
        testBtn1.addTarget(self, action: #selector(testTap(sender:)), for: .touchUpInside)
        testBtn2.addTarget(self, action: #selector(testTap(sender:)), for: .touchUpInside)
        testBtn1.tag = 1
        testBtn2.tag = 2
        //:test stuff
        containerView.addSubviews(meWhichPlayerView, connectButton, testLabel, testBtn1, testBtn2)
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
            //test stuff:
            testLabel.topAnchor.constraint(equalTo: meWhichPlayerView.bottomAnchor, constant: 50),
            testLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            connectButton.topAnchor.constraint(equalTo: testLabel.bottomAnchor, constant: SNKPadding.big),
            connectButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            connectButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            testBtn1.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            testBtn1.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            testBtn1.topAnchor.constraint(equalTo: connectButton.bottomAnchor, constant: 100),
            testBtn2.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            testBtn2.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            testBtn2.topAnchor.constraint(equalTo: testBtn1.bottomAnchor, constant: SNKPadding.small)
        ])
    }
    
}
