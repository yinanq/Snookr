//
//  ConnectVC+CBCentralManagerDelegate.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/24/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import CoreBluetooth

extension ConnectVC: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown: print("central.state is .unknown")
        case .resetting: print("central.state is .resetting")
        case .unsupported: print("central.state is .unsupported")
        case .unauthorized: print("central.state is .unauthorized")
        case .poweredOff:
            print("central.state is .poweredOff")
            cbDisconnectOrCancel()
            updateCBState(to: .notConnected)
        case .poweredOn:
            print("central.state is .poweredOn")
            cbStateCentral = .notConnected
            cbCentralManager.scanForPeripherals(withServices: [cbSnookrUUID], options: nil)
        @unknown default: print("central.state is @unknown default")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("central did discover peripheral \(peripheral.name ?? "w/o name")")
        cbStateCentral = .notConnected
        guard cbUserDefinedLocalName != nil else {
            print("error: user defined local name is still nil when central did discover peripheral")
            cbDisconnectOrCancel()
            updateCBState(to: .notConnected)
            return
        }
        if advertisementData[CBAdvertisementDataLocalNameKey] as? String == cbUserDefinedLocalName! {
            print("central confirmed matching user defined local name from peripheral")
            cbChosenPeripheral = peripheral
            cbChosenPeripheral.delegate = self
            central.connect(cbChosenPeripheral, options: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("central did connect peripheral \(peripheral.name ?? "w/o name")")
        cbStateCentral = .notConnected
        central.stopScan()
        print("central stopped scanning, assumed for central.stopScan()")
        peripheral.delegate = self
        peripheral.discoverServices([cbSnookrServiceUUID])
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("central did fail to connect peripheral \(peripheral.name ?? "w/o name"), likely because peripheral canceled connecting")
        cbDisconnectOrCancel()
        updateCBState(to: .notConnected)
    }
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("central did disconnect peripheral \(peripheral.name ?? "w/o name")")
    }
}
