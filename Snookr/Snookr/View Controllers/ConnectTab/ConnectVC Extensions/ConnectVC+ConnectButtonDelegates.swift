//
//  ConnectVC+ConnectButtonDelegates.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/26/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

extension ConnectVC: ConnectButtonDelegate, DisconnectAlertVCDelegate {
    
    func didTapConnectButton() {
        switch cbState {
        case .notConnected: //button is Connect
            cbStartConnecting()
            updateCBState(to: .isConnecting)
        case .isConnecting: //button is Cancel or Disconnect
            disconnect()
        case .isConnected:
            didTapDisconnectButton()
        }
    }
    
    private func disconnect() {
        cbDisconnectOrCancel()
        updateCBState(to: .notConnected)
    }
    
    private func didTapDisconnectButton() {
        let alertVC = DisconnectAlertVC(title: "Sure?", body: "Gonna disconnect from your opponent. Sure you wanna do it?", cancelBtnTitle: "No", confirmBtnTitile: "Yes", delegate: self)
        alertVC.modalPresentationStyle = .overCurrentContext
        alertVC.modalTransitionStyle = .crossDissolve
        present(alertVC, animated: true)
    }
    
    func didTapConfirmToDisconnect() { disconnect() }
    
}
