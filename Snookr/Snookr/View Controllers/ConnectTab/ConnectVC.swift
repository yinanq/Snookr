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
    
    var testLabel: SNKLabel!
    let connectButton = SNKButton()
    let testBtn1 = SNKButton()
    let testBtn2 = SNKButton()
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        layoutUI()
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
    
    private func configureUI() {
        connectButton.set(title: "Connect with Opponent", style: .solid)
        connectButton.addTarget(self, action: #selector(didTapConnectButton), for: .touchUpInside)
        view.addSubview(connectButton)
        testLabel = SNKLabel(fontSize: 100, fontWeight: .bold)
        testLabel.text = "0"
        testBtn1.set(title: "1", style: .solid)
        testBtn2.set(title: "2", style: .solid)
        testBtn1.addTarget(self, action: #selector(testTap(sender:)), for: .touchUpInside)
        testBtn2.addTarget(self, action: #selector(testTap(sender:)), for: .touchUpInside)
        testBtn1.tag = 1
        testBtn2.tag = 2
        view.addSubviews(testLabel, testBtn1, testBtn2)
    }
    
    private func layoutUI() {
        NSLayoutConstraint.activate([
            connectButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            connectButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big),
            connectButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            testBtn1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            testBtn1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big),
            testBtn1.topAnchor.constraint(equalTo: connectButton.bottomAnchor, constant: 100),
            testBtn2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            testBtn2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big),
            testBtn2.topAnchor.constraint(equalTo: testBtn1.bottomAnchor, constant: SNKPadding.small),
            testLabel.bottomAnchor.constraint(equalTo: connectButton.topAnchor, constant: -100),
            testLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
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
    
}
