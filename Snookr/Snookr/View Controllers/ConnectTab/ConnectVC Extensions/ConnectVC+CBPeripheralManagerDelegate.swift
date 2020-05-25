//
//  ConnectVC+CBPeripheralManagerDelegate.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/24/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import CoreBluetooth

extension ConnectVC: CBPeripheralManagerDelegate {
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        switch peripheral.state {
        case .unknown: print("CBPeripheralManager.state is .unknown")
        case .resetting: print("CBPeripheralManager.state is .resetting")
        case .unsupported: print("CBPeripheralManager.state is .unsupported")
        case .unauthorized: print("CBPeripheralManager.state is .unauthorized")
        case .poweredOff: print("CBPeripheralManager.state is .poweredOff")
            
        case .poweredOn:
            print("CBPeripheralManager.state is .poweredOn")
            let characteristic = CBMutableCharacteristic(type: cbSnookrCharacteristicUUID, properties: .write, value: nil, permissions: .writeable)
            let service = CBMutableService(type: cbSnookrServiceUUID, primary: true)
            service.characteristics = [characteristic]
            peripheral.add(service)
            guard cbUserDefinedLocalName != nil else {
                print("error: cbUserDefinedLocalName is still nil when CBPeripheralManager.startAdvertising")
                return
            }
            peripheral.startAdvertising([CBAdvertisementDataServiceUUIDsKey: [cbSnookrUUID], CBAdvertisementDataLocalNameKey: cbUserDefinedLocalName!])
            
        @unknown default: print("CBPeripheralManager.state is @unknown default")
        }
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        print("CBPeripheralManager didReceiveWrite requests")
        cbPeripheralManager.stopAdvertising()
        for request in requests {
            if let value = request.value {
                print(String(data: value, encoding: .utf8) as String?)
            }
            self.cbPeripheralManager.respond(to: request, withResult: .success)
        }
    }
    
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) { print("peripheral did start advertising") }
    func peripheral(_ peripheral: CBPeripheral, didModifyServices invalidatedServices: [CBService]) { print("peripheral did modify services") }
}
