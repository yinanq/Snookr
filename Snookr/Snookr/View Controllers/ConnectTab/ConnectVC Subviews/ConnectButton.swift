//
//  ConnectButton.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/22/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

protocol ConnectButtonDelegate: class {
    func didTapConnectButton()
}

class ConnectButton: SNKButton {
    
    weak var delegate: ConnectButtonDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func configure() {
        set(title: "Connect", style: .solid)
        addTarget(self, action: #selector(didTapConnectButton), for: .touchUpInside)
    }
    
    @objc func didTapConnectButton() { delegate.didTapConnectButton() }
    
    func setToConnectButton() {
        setTitle("Connect", for: .normal)
        backgroundColor = SNKColor.foreground
    }
    func setToCancelButton() {
        setTitle("Cancel", for: .normal)
        backgroundColor = SNKColor.foregroundSecondary
    }
    func setToDisconnectButton() {
        setTitle("Disconnect", for: .normal)
        backgroundColor = SNKColor.destructive
    }
    
}
