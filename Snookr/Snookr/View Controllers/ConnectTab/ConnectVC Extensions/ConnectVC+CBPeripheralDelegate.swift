//
//  ConnectVC+CBPeripheralDelegate.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/24/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import CoreBluetooth

extension ConnectVC: CBPeripheralDelegate {
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
//        print("central did discover Services on peripheral \(peripheral.name ?? "w/o name")")
        cbStateCentral = .notConnected
        guard let services = peripheral.services else {
            print("central discovered Services is nil, likely because peripheral canceled connecting")
            disconnectAndUpdateCBState()
            return
        }
        guard !services.isEmpty else {
            print("central discovered Services is empty, likely because peripheral canceled connecting")
            disconnectAndUpdateCBState()
            return
        }
        peripheral.discoverCharacteristics([cbSnookrCharacteristicUUID], for: services[0])
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
//        print("central did discover Characteristics on \(peripheral.name ?? "w/o name")")
        cbStateCentral = .notConnected
        guard let characteristics = service.characteristics else {
            print("central discovered Characteristics is nil, likely because peripheral canceled connecting")
            disconnectAndUpdateCBState()
            return
        }
        guard !characteristics.isEmpty else {
            print("central discovered Characteristics is empty, likely because peripheral canceled connecting")
            disconnectAndUpdateCBState()
            return
        }
//        print(characteristics.count)
        for characteristic in characteristics {
//            print(characteristic.properties)
            if characteristic.properties == CBCharacteristicProperties.notify {
                peripheral.setNotifyValue(true, for: characteristic)
//                print("subscribed to readable characteristic (pending confirmation from peripheral")
            } else {
                cbChosenCharacteristic = characteristic
//                print("saved writable characteristic")
                sendConnectConfAndStartingScoreInfo()
                cbStateCentral = .isConnected
                if cbStatePeripheral == .isConnected {
                    updateCBState(to: .isConnected)
                }
            }
//            if characteristic.properties.rawValue == 136 {
//                cbChosenCharacteristic = characteristic
//                print("saved writable characteristic")
//                sendConnectConfAndStartingScoreInfo()
//                cbStateCentral = .isConnected
//                if cbStatePeripheral == .isConnected {
//                    updateCBState(to: .isConnected)
//                }
//            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
//        print("peripheral confirmed subscription of characteristic")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
//        print("peripheral did update value for characteristic")
        if let data = characteristic.value {
            if data == cbPeripheralNotifyDataString.data(using: .utf8) {
//                print("peripheral has disconnected and informed central to disconnect too")
                disconnectAndUpdateCBState()
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didModifyServices invalidatedServices: [CBService]) {
//        print("peripheral did modify services, like because peripheral disconnected and became nil")
        disconnectAndUpdateCBState()
    }
    
    private func sendConnectConfAndStartingScoreInfo() {
        //        print("sendConnectConfAndStartingScoreInfo")
        var myName: String
        var myFrame: Int
        var myScore: Int
        switch opponentIs {
        case .player1:
            myName = player2.name
            myFrame = defaults.integer(forKey: SNKCommonKey.player2sFrame)
            myScore = defaults.integer(forKey: SNKCommonKey.player2sScore)
        case .player2:
            myName = player1.name
            myFrame = defaults.integer(forKey: SNKCommonKey.player1sFrame)
            myScore = defaults.integer(forKey: SNKCommonKey.player1sScore)
        }
        cbSend(snkCBDataType: SNKcbDataType.cbConnected, playerName: myName, frame: myFrame, score: myScore)
    }
    
}
