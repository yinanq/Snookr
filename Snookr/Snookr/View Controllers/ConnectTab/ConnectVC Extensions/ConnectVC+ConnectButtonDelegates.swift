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
            disconnectAndUpdateCBState()
        case .isConnected:
            didTapDisconnectButton()
        }
    }
    
    private func didTapDisconnectButton() {
        let alertVC = DisconnectAlertVC(title: "Sure?", body: "Disconnect from your opponent?", cancelBtnTitle: "No", confirmBtnTitile: "Yes", delegate: self)
        alertVC.modalPresentationStyle = .overCurrentContext
        alertVC.modalTransitionStyle = .crossDissolve
        present(alertVC, animated: true)
    }
    
    func didTapConfirmToDisconnect() { disconnectAndUpdateCBState() }
    
}
