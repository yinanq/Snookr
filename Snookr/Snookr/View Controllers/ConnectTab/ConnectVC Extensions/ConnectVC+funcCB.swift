//
//  ConnectVC+funcCB.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/24/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit
import CoreBluetooth
import AVFoundation

extension ConnectVC {
    
    func cbSend(snkCBDataType: String, playerName: String? = nil, frame: Int? = nil, score: Int? = nil, scoreHist1: Int? = nil, scoreHist2: Int? = nil, scoreHist3: Int? = nil) {
        let data = SNKcbData(snkCBDataType: snkCBDataType, playerName: playerName, frame: frame, score: score, scoreHist1: scoreHist1, scoreHist2: scoreHist2, scoreHist3: scoreHist3)
        cbSend(data)
    }
    
    func cbSend(_ data: SNKcbData) {
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
    
    func disconnectAndUpdateCBState() {
        cbDisconnectOrCancel()
        updateCBState(to: .notConnected)
    }
    
    private func cbDisconnectOrCancel() {
        if let peripheralManager = cbPeripheralManager {
//            print("cbDisconnectOrCancel by cbPeripheralManager")
            peripheralManager.stopAdvertising()
//            cbPeripheralNotifyData = cbPeripheralNotifyDataString.data(using: .utf8)
            if let characteristic = cbNotifierCharacteristic {
                if let data = cbPeripheralNotifyData {
                    peripheralManager.updateValue(data, for: characteristic, onSubscribedCentrals: nil)
                }
                cbNotifierCharacteristic = nil
            }
            cbPeripheralManager = nil
        }
        if let centralManager = cbCentralManager {
//            print("cbDisconnectOrCancel by cbCentralManager")
            centralManager.stopScan()
            cbSend(snkCBDataType: SNKcbDataType.cbDisconnected)
            cbChosenCharacteristic = nil
            cbChosenPeripheral = nil
            cbCentralManager = nil
        }
    }
    
    func updateCBState(to cbState: SNKcbState) {
        self.cbState = cbState
        pseudoPersistCBState()
        notifCtr.post(name: .connectVCChangedCBState, object: self.cbState)
        switch self.cbState {
        case .notConnected:
            AudioServicesPlaySystemSoundWithCompletion(SNKSoundID.didDisconnect, nil)
            unlockOpponentInfoEditability()
            meWhichPlayerView.unlockToggleButton()
            connectButton.setToConnectButton()
            cbStateCentral = .notConnected
            cbStatePeripheral = .notConnected
            connectCodeTextField.enable()
            connectedTextView.setToNotConnected()
            tabBarItem.image = SNKTabBarImage.connect
            tabBarItem.title = SNKTabBarTitle.connect
        case .isConnecting:
            lockOpponentInfoEditability()
            meWhichPlayerView.lockToggleButton()
            connectButton.setToCancelButton()
            connectCodeTextField.disable()
        case .isConnected:
            AudioServicesPlaySystemSoundWithCompletion(SNKSoundID.didConnect, nil)
            connectButton.setToDisconnectButton()
            connectedTextView.setToConnected()
            tabBarItem.image = SNKTabBarImage.connected
            tabBarItem.title = SNKTabBarTitle.connected
            //should not need, unless skipped isConnecting:
            lockOpponentInfoEditability()
            meWhichPlayerView.lockToggleButton()
            connectCodeTextField.disable()
        }
    }
    
    //pseudoPersistCBState works like a global variable, for other VCs to first launch with correct Bluetooth connection state marker set by Connect VC, but when app launches from killed, first tab Connect VC overwrites saved state to notConnected, in case app was killed and persistence didn't have chance to update saved state to notConnected:
    func pseudoPersistCBState() { defaults.set(cbState.rawValue, forKey: SNKCommonKey.cbStateRawValue) }
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
    
    func cbPresentBluetoothPermissionAlert() {
        let ac = UIAlertController(title: "Bluetooth permission needed", message: "Snookr needs to use Bluetooth to sync score data between you and your opponent. Please give permission in the Settings app > Snookr > Bluetooth.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
            self.disconnectAndUpdateCBState()
        }))
        ac.overrideUserInterfaceStyle = .dark
        present(ac, animated: true)
    }
    
    func cbPresentBluetoothNotAvailableAlert() {
        let ac = UIAlertController(title: "Bluetooth unsupported :(", message: "It appears this device does not have Bluetooth. If so, the Connect feature will not work on this device :(", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
            self.disconnectAndUpdateCBState()
        }))
        ac.overrideUserInterfaceStyle = .dark
        present(ac, animated: true)
    }
}
