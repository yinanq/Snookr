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
                        //name:
                        if let data = data.playerName { cbUpdateOpponentName(to: data) }
                        //starting frame:
                        if let data = data.frame {
                            notifCtr.post(name: .connectVCReceivedUpdatedFrame, object: data) //for common case
                            cbPersistOpponentFrame(to: data) //for edge case of relevant vc has never been initialized since app launch
                        }
                        //starting score:
                        notifCtr.post(name: .connectVCReceivedUpdatedScore, object: data)
                        if let data = data.score {
                            cbPersistOpponentScore(to: data)
                        }
                    case SNKcbDataType.cbDisconnected:
                        print("peripheral received cbDisconnected from central")
                        disconnectAndUpdateCBState()
                    //score:
                    case SNKcbDataType.socre:
                        notifCtr.post(name: .connectVCReceivedUpdatedScore, object: data)
                        if let data = data.score {
                            cbPersistOpponentScore(to: data)
                        }
                    case SNKcbDataType.resetScore:
                        notifCtr.post(name: .connectVCReceivedResetScores, object: nil)
                        cbPersistResetScroes()
                    //frame:
                    case SNKcbDataType.frame:
                        if let data = data.frame {
                            notifCtr.post(name: .connectVCReceivedUpdatedFrame, object: data)
                            cbPersistOpponentFrame(to: data)
                        }
                    case SNKcbDataType.resetFrame:
                        notifCtr.post(name: .connectVCReceivedResetFrames, object: nil)
                        cbPersistResetFrames()
                    //name:
                    case SNKcbDataType.playerName:
                        if let opponentName = data.playerName { cbUpdateOpponentName(to: opponentName) }
                    default: print("error: peripheral found invalid case in decoded data from encoded data from central")
                    }
                } catch {
                    print("error: peripheral failed to decode encoded data from central")
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
            disconnectAndUpdateCBState()
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
        disconnectAndUpdateCBState()
    }
}
