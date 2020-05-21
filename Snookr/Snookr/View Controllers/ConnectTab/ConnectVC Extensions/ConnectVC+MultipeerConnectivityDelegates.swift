//
//  ConnectVC+MultipeerConnectivityDelegates.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/20/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import MultipeerConnectivity

extension ConnectVC: MCNearbyServiceAdvertiserDelegate {
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        print("MCNearbyServiceAdvertiser didReceiveInvitationFromPeer \(peerID)")
//        let ac = UIAlertController(title: "Connection Request", message: "\(peerID) wants to connect with you", preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "Accept", style: .default, handler: acceptConnection))
//        ac.addAction(UIAlertAction(title: "Reject", style: .default))
//        ac.view.tintColor = SNKColor.foreground
//        present(ac, animated: true)
        invitationHandler(true, self.mcSession)
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        print("MCNearbyServiceAdvertiser didNotStartAdvertisingPeer, error:")
        print(error)
    }
    
    private func acceptConnection(action: UIAlertAction) {
        print("acceptConnection")
    }
    
}

extension ConnectVC: MCSessionDelegate {
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        print("MCSession didReceive data fromPeer \(peerID)")
        DispatchQueue.main.async { [weak self] in
            if let testInt = Int(String(decoding: data, as: UTF8.self)) {
                self?.testLabel.text = "\(testInt)"
            }
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        print("MCSession didReceive stream")
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        print("MCSession didStartReceivingResourceWithName")
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        print("MCSession didFinishReceivingResourceWithName")
    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        print("MCSession didChange state")
        switch state {
        case .connected: print("\(peerID.displayName) is connected")
        case .connecting: print("\(peerID.displayName) is connecting")
        case .notConnected: print("\(peerID.displayName) is not connected")
        @unknown default: print("\(peerID.displayName) is in unknown state")
        }
    }
    
}

extension ConnectVC: MCBrowserViewControllerDelegate {
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) { dismiss(animated: true) }
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) { dismiss(animated: true) }
}

//extension ConnectVC: MCNearbyServiceBrowserDelegate {
//
//    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
//        print("MCNearbyServiceBrowser foundPeer \(peerID)")
//    }
//
//    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
//        print("MCNearbyServiceBrowser lostPeer \(peerID)")
//    }
//
//    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
//        print("MCNearbyServiceBrowser didNotStartBrowsingForPeers")
//        print(error)
//    }
//}
