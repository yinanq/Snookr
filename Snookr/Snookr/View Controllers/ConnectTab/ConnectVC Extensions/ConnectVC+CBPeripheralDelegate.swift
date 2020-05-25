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
        guard let services = peripheral.services else {
            print("error: discovered Services is nil")
            return
        }
        peripheral.discoverCharacteristics([cbSnookrCharacteristicUUID], for: services[0])
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        print("central did discover Characteristics on \(peripheral.name ?? "w/o name")")
        guard let characteristics = service.characteristics else {
            print("error: discovered Characteristics is nil")
            return
        }
        cbChosenCharacteristic = characteristics[0]
        guard let data = SNKCBConnectionAck.connected.data(using: .utf8) else { return }
        peripheral.writeValue(data, for: cbChosenCharacteristic, type: .withResponse)
    }
    
}
