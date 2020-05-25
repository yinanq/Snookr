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
            cbCentralManager.scanForPeripherals(withServices: [cbSnookrUUID], options: nil)
        @unknown default: print("central.state is @unknown default")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("central did discover peripheral \(peripheral.name ?? "w/o name")")
        guard cbUserDefinedLocalName != nil else {
            print("error: cbUserDefinedLocalName is still nil when central didDiscover peripheral")
            return
        }
        if advertisementData[CBAdvertisementDataLocalNameKey] as? String == cbUserDefinedLocalName! {
            cbChosenPeripheral = peripheral
            cbChosenPeripheral.delegate = self
            central.connect(cbChosenPeripheral, options: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("central didConnect peripheral \(peripheral.name ?? "w/o name")")
        central.stopScan()
        print("central stopped scanning, for central.stopScan()")
        peripheral.delegate = self
        peripheral.discoverServices([cbSnookrServiceUUID])
    }
    
}
