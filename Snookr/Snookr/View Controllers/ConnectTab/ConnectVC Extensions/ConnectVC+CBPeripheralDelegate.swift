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
        print("central did discover Services on peripheral \(peripheral.name ?? "w/o name")")
        cbStateCentral = .notConnected
        guard let services = peripheral.services else {
            print("central discovered Services is nil, likely because peripheral canceled connecting")
            cbDisconnectOrCancel()
            updateCBState(to: .notConnected)
            return
        }
        guard !services.isEmpty else {
            print("central discovered Services is empty, likely because peripheral canceled connecting")
            cbDisconnectOrCancel()
            updateCBState(to: .notConnected)
            return
        }
        peripheral.discoverCharacteristics([cbSnookrCharacteristicUUID], for: services[0])
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        print("central did discover Characteristics on \(peripheral.name ?? "w/o name")")
        cbStateCentral = .notConnected
        guard let characteristics = service.characteristics else {
            print("central discovered Characteristics is nil, likely because peripheral canceled connecting")
            cbDisconnectOrCancel()
            updateCBState(to: .notConnected)
            return
        }
        guard !characteristics.isEmpty else {
            print("central discovered Characteristics is empty, likely because peripheral canceled connecting")
            cbDisconnectOrCancel()
            updateCBState(to: .notConnected)
            return
        }
        cbChosenCharacteristic = characteristics[0]
        if let data = SNKCBConnectionAck.connected.data(using: .utf8) {
            peripheral.writeValue(data, for: cbChosenCharacteristic, type: .withResponse)
        }
        cbStateCentral = .isConnected
        if cbStatePeripheral == .isConnected {
            updateCBState(to: .isConnected)
        }
    }
    
}
