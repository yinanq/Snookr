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
    
    var mcPeerID: MCPeerID?
    var mcSession: MCSession?
    var mcAdAssistant: MCAdvertiserAssistant?
    
    let connectButton = SNKButton()
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        layoutUI()
        mcPeerID = MCPeerID(displayName: UIDevice.current.name) //temp
        mcSession = MCSession(peer: mcPeerID!, securityIdentity: nil, encryptionPreference: .required)
        mcSession?.delegate = self
    }
    
    func hostSession(action: UIAlertAction) {
        guard let mcSession = mcSession else { return }
        mcAdAssistant = MCAdvertiserAssistant(serviceType: SNKmcServiceType, discoveryInfo: nil, session: mcSession)
    }
    
    func joinSession(action: UIAlertAction) {
        guard let mcSession = mcSession else { return }
        let mcBrowserVC = MCBrowserViewController(serviceType: SNKmcServiceType, session: mcSession)
        mcBrowserVC.delegate = self
        present(mcBrowserVC, animated: true)
    }
    
    @objc func didTapConnectButton() {
        let ac = UIAlertController(title: "Connect with Opponent", message: "temp message", preferredStyle: .actionSheet)
        ac.view.tintColor = SNKColor.foreground
        ac.addAction(UIAlertAction(title: "temp host session", style: .default, handler: hostSession)) //temp
        ac.addAction(UIAlertAction(title: "temp join session", style: .default, handler: joinSession)) //temp
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    private func configureUI() {
        connectButton.set(title: "Connect with Opponent", style: .solid)
        connectButton.addTarget(self, action: #selector(didTapConnectButton), for: .touchUpInside)
        view.addSubview(connectButton)
    }
    
    private func layoutUI() {
        NSLayoutConstraint.activate([
            connectButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            connectButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big),
            connectButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
}
