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
    
    let connectTitle = "Connect to Opponent"
    let ai = UIActivityIndicatorView(style: .medium)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func configure() {
        set(title: connectTitle, style: .solid)
        addTarget(self, action: #selector(didTapConnectButton), for: .touchUpInside)
        addActivityIndicator()
    }
    
    @objc func didTapConnectButton() { delegate.didTapConnectButton() }
    
    func setToConnectButton() {
        setTitle(connectTitle, for: .normal)
        backgroundColor = SNKColor.foreground
        ai.stopAnimating()
    }
    func setToCancelButton() {
        setTitle("Cancel", for: .normal)
        ai.startAnimating()
    }
    func setToDisconnectButton() {
        setTitle("Disconnect", for: .normal)
        backgroundColor = SNKColor.destructive
        ai.stopAnimating()
    }
    
    private func addActivityIndicator() {
        addSubview(ai)
        ai.color = SNKColor.background
        ai.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ai.centerYAnchor.constraint(equalTo: centerYAnchor),
            ai.leadingAnchor.constraint(equalTo: titleLabel!.trailingAnchor, constant: SNKPadding.small)
        ])
    }
    
}
