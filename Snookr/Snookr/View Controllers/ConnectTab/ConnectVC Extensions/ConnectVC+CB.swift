//
//  ConnectVC+CB.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/24/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import CoreBluetooth

extension ConnectVC: ConnectButtonDelegate {
    func didTapConnectButton() {
        switch mcState {
        case .notConnected: //button is Connect
            cbStartConnecting()
            updateMCState(to: .isConnecting)
        case .isConnecting, .isConnected: //button is Cancel or Disconnect
            mcDisconnect()
            updateMCState(to: .notConnected)
        }
    }
}

extension ConnectVC {
    
    func cbStartConnecting() {
        cbCentralManager = CBCentralManager(delegate: self, queue: nil)
        cbPeripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    }
    
}
