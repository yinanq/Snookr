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
        switch cbState {
        case .notConnected: //button is Connect
            cbStartConnecting()
            updateCBState(to: .isConnecting)
        case .isConnecting, .isConnected: //button is Cancel or Disconnect
            cbDisconnectOrCancel()
            updateCBState(to: .notConnected)
        }
    }
}

extension ConnectVC {
    
    func cbStartConnecting() {
        cbCentralManager = CBCentralManager(delegate: self, queue: nil)
        cbPeripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    }
    
    func cbDisconnectOrCancel() {
        if let centralManager = cbCentralManager {
            centralManager.stopScan()
            if let peripheral = cbChosenPeripheral {
                if let characteristic = cbChosenCharacteristic {
                    if let data = SNKCBConnectionAck.disconnected.data(using: .utf8) { peripheral.writeValue(data, for: characteristic, type: .withResponse) }
                    cbChosenCharacteristic = nil
                }//else is still-ok edge case: Cancel is tapped when central has found peripheral and possibily peripheral's service too but hasn't found peripheral's service's characteristic
                centralManager.cancelPeripheralConnection(peripheral)
                cbChosenPeripheral = nil
            }
            cbCentralManager = nil
        }
        if let peripheralManager = cbPeripheralManager {
            peripheralManager.stopAdvertising()
            cbPeripheralManager = nil
        }
    }
    
    func updateCBState(to cbState: SNKcbState) {
        self.cbState = cbState
        pseudoPersistCBState()
        notifCtr.post(name: .connectVCChangedCBState, object: self.cbState)
        switch self.cbState {
        case .notConnected:
            unlockOpponentInfoEditability()
            meWhichPlayerView.unlockToggleButton()
            connectButton.setToConnectButton()
            cbStateCentral = .notConnected
            cbStatePeripheral = .notConnected
        case .isConnected:
            lockOpponentInfoEditability()
            meWhichPlayerView.lockToggleButton()
            connectButton.setToDisconnectButton()
        case .isConnecting:
            lockOpponentInfoEditability()
            meWhichPlayerView.lockToggleButton()
            connectButton.setToCancelButton()
        }
    }
    
    //like a global variable, for other VCs to first launch with correct cbState, but overwrite persisted value when app launches:
    func pseudoPersistCBState() { defaults.set(cbState.rawValue, forKey: SNKCommonKey.cbStateRawValue) }//to change if cb connection auto resumes when app relaunches from killed
    private func lockOpponentInfoEditability() {
        meWhichPlayerView.lockToggleButton()
        switch opponentIs {
        case .player1:
            playerNamesView.textView1.isEditable = false
        case .player2:
            playerNamesView.textView2.isEditable = false
        }
    }
    private func unlockOpponentInfoEditability() {
        meWhichPlayerView.unlockToggleButton()
        playerNamesView.textView1.isEditable = true
        playerNamesView.textView2.isEditable = true
    }
}
