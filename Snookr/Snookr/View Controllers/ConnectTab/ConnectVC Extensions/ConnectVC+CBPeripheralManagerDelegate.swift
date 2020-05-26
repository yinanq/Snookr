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
//        print("peripheral did receive write requests")
        cbPeripheralManager.stopAdvertising()
        for request in requests {
            if let data = request.value {
                let jD = JSONDecoder()
                do {
                    let data = try jD.decode(SNKcbData.self, from: data)
                    switch data.snkCBDataType {
                    case SNKcbDataType.cbConnected:
                        print("peripheral received cbConnected from central")
                        cbStatePeripheral = .isConnected
                        if cbStateCentral == .isConnected {
                            updateCBState(to: .isConnected)
                        }
                        if let opponentName = data.playerName { cbUpdateOpponentName(to: opponentName) }
                        if let opponentFrame = data.frame { cbPersistOpponentFrame(to: opponentFrame) }
                    case SNKcbDataType.cbDisconnected:
                        print("peripheral received cbDisconnected from central")
                        cbDisconnectOrCancel()
                        updateCBState(to: .notConnected)
                    case SNKcbDataType.socre:
                        print(".socre.")
                    case SNKcbDataType.frame:
                        if let opponentFrame = data.frame {
                            notifCtr.post(name: .connectVCReceivedUpdatedFrame, object: opponentFrame)
                            cbPersistOpponentFrame(to: opponentFrame)
                        }
                    case SNKcbDataType.resetScore:
                        print(".resetScore.")
                    case SNKcbDataType.resetFrame:
                        notifCtr.post(name: .connectVCReceivedResetFrames, object: nil)
                    case SNKcbDataType.playerName:
                        if let opponentName = data.playerName { cbUpdateOpponentName(to: opponentName) }
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
