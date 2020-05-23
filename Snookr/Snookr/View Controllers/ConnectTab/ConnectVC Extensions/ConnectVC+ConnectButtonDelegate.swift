//
//  ConnectVC+ConnectButtonDelegate.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/22/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import MultipeerConnectivity

extension ConnectVC: ConnectButtonDelegate {
    
    func didTapConnectButton() {
        switch mcState {
        case .notConnected: //button is Connect
            mcStartConnecting()
            mcState = .isConnecting
            connectButton.setToCancelButton()
        case .isConnecting, .isConnected: //button is Cancel or Disconnect
            mcDisconnect()
            mcState = .notConnected
            connectButton.setToConnectButton()
        }
    }
    
}
