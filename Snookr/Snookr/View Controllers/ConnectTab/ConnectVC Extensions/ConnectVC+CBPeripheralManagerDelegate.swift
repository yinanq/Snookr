//
//  ConnectVC+CBPeripheralManagerDelegate.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/24/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import CoreBluetooth

extension ConnectVC: CBPeripheralManagerDelegate {
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        print("peripheral did receive write requests")
        cbPeripheralManager.stopAdvertising()
        for request in requests {
            if let data = request.value {
                let jD = JSONDecoder()
                do {
                    let data = try jD.decode(SNKcbData.self, from: data)
                    switch data.snkCBDataType {
                    case SNKcbDataType.cbConnected:
                        print("received cbConnected")
                        cbStatePeripheral = .isConnected
                        if cbStateCentral == .isConnected {
                            updateCBState(to: .isConnected)
                        }
                    case SNKcbDataType.cbDisconnected:
                        print("received cbDisconnected")
                        cbDisconnectOrCancel()
                        updateCBState(to: .notConnected)
                    case SNKcbDataType.socre:
                        print(".socre.")
                    case SNKcbDataType.frame:
                        print(".frame.")
                    case SNKcbDataType.resetScore:
                        print(".resetFrame.")
                    case SNKcbDataType.resetFrame:
                        print(".resetFrame.")
                    case SNKcbDataType.playerName:
                        switch self.opponentIs {
                        case .player1:
                            self.cbUpdateName(of: &self.player1, to: data.playerName ?? "?")
                        case .player2:
                            self.cbUpdateName(of: &self.player2, to: data.playerName ?? "?")
                        }
                    default: print("error: invalid case, in peripheral did receive write requests")
                    }
                } catch {
                    print("error: decoding failed, in peripheral did receive write requests")
                }
            }
            if let peripherlManager = self.cbPeripheralManager { peripherlManager.respond(to: request, withResult: .success) }
        }
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        switch peripheral.state {
        case .unknown: print("peripheral.state is .unknown")
        case .resetting: print("peripheral.state is .resetting")
        case .unsupported: print("peripheral.state is .unsupported")
        case .unauthorized: print("peripheral.state is .unauthorized")
        case .poweredOff:
            print("peripheral.state is .poweredOff")
            cbDisconnectOrCancel()
            updateCBState(to: .notConnected)
        case .poweredOn:
            print("peripheral.state is .poweredOn")
            cbStatePeripheral = .notConnected
            let characteristic = CBMutableCharacteristic(type: cbSnookrCharacteristicUUID, properties: .write, value: nil, permissions: .writeable)
            let service = CBMutableService(type: cbSnookrServiceUUID, primary: true)
            service.characteristics = [characteristic]
            peripheral.add(service)
            guard cbUserDefinedLocalName != nil else {
                print("error: cbUserDefinedLocalName is still nil when peripheral is about to start advertising")
                return
            }
            peripheral.startAdvertising([CBAdvertisementDataServiceUUIDsKey: [cbSnookrUUID], CBAdvertisementDataLocalNameKey: cbUserDefinedLocalName!])
        @unknown default: print("peripheral.state is @unknown default")
        }
    }
    
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        print("peripheral did start advertising")
        cbStatePeripheral = .notConnected
    }
    
    func peripheral(_ peripheral: CBPeripheral, didModifyServices invalidatedServices: [CBService]) {
        print("peripheral did modify services")
        cbDisconnectOrCancel()
        updateCBState(to: .notConnected)
    }
}
