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
    
    func cbSend(snkCBDataType: String, playerName: String? = nil, frame: Int? = nil, score: Int? = nil, scoreHist1: Int? = nil, scoreHist2: Int? = nil, scoreHist3: Int? = nil) {
        let data = SNKcbData(snkCBDataType: snkCBDataType, playerName: playerName, frame: frame, score: score, scoreHist1: scoreHist1, scoreHist2: scoreHist2, scoreHist3: scoreHist3)
        let jE = JSONEncoder()
        do {
            let data = try jE.encode(data)
            guard let peripheral = cbChosenPeripheral, let characteristic = cbChosenCharacteristic else {
                print("error: no cbChosenPeripheral and/or cbChosenCharacteristic when trying to send data")
                return
            }
            peripheral.writeValue(data, for: characteristic, type: .withResponse)
        } catch {
            print("error: encoding failed, in cbSend.")
        }
    }
    
    func cbStartConnecting() {
        cbCentralManager = CBCentralManager(delegate: self, queue: nil)
        cbPeripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    }
    
    func cbDisconnectOrCancel() {
        if let centralManager = cbCentralManager {
            centralManager.stopScan()
            cbSend(snkCBDataType: SNKcbDataType.cbDisconnected)
            cbChosenCharacteristic = nil
            cbChosenPeripheral = nil
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
