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
        case .poweredOff:
            print("CBPeripheralManager.state is .poweredOff")
            cbDisconnectOrCancel()
            updateCBState(to: .notConnected)
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
                let string = String(data: value, encoding: .utf8)!
                print("opponent's central has \(string)")
                if string == SNKCBConnectionAck.connected {
                    cbStatePeripheral = .isConnected
                    if cbStateCentral == .isConnected {
                        updateCBState(to: .isConnected)
                    }
                }
                if string == SNKCBConnectionAck.disconnected {
                    cbDisconnectOrCancel()
                    updateCBState(to: .notConnected)
                }
            }
            if let peripherlManager = self.cbPeripheralManager {
                peripherlManager.respond(to: request, withResult: .success)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        //to handle response if going with central driven approach?
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didSubscribeTo characteristic: CBCharacteristic) {
        print("central did subscribe to characteristic \(characteristic)")
    }
    
    func peripheralManagerIsReady(toUpdateSubscribers peripheral: CBPeripheralManager) {
        print("more space in the transmit queue became available")
    }
    
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) { print("peripheral did start advertising") }
    func peripheral(_ peripheral: CBPeripheral, didModifyServices invalidatedServices: [CBService]) { print("peripheral did modify services") }
}
