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
        print("advertiser didReceiveInvitationFromPeer \(peerID.displayName)")
        if peerID.displayName == mcPeerIDDisplayName {
            invitationHandler(true, self.mcSession)
        } else {
            invitationHandler(false, self.mcSession)
            print("error: hmm someone with the wrong password tried to join the action")
        }
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) { print("MCNearbyServiceAdvertiser didNotStartAdvertisingPeer, error: \(error)") }
    
}

extension ConnectVC: MCSessionDelegate {
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        print("MCSession didReceive data fromPeer \(peerID.displayName)")
        DispatchQueue.main.async { [weak self] in
            if let testInt = Int(String(decoding: data, as: UTF8.self)) {
                self?.testLabel.text = "\(testInt)"
            }
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        print("MCSession didReceive stream fromPeer \(peerID.displayName)")
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        print("MCSession didStartReceivingResourceWithName fromPeer \(peerID.displayName)")
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        print("MCSession didFinishReceivingResourceWithName fromPeer \(peerID.displayName)")
    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .connecting: print("\(peerID.displayName) is connecting")
        case .connected:
            print("\(peerID.displayName) is connected")
            mcAdvertiser?.stopAdvertisingPeer()
            mcBrowser?.stopBrowsingForPeers()
            mcAdvertiser = nil
            mcBrowser = nil
        case .notConnected: print("\(peerID.displayName) is not connected")
        @unknown default: print("\(peerID.displayName) is in unknown state")
        }
    }
    
}

extension ConnectVC: MCNearbyServiceBrowserDelegate {

    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        print("MCNearbyServiceBrowser foundPeer \(peerID.displayName)")
        guard mcPeerID != nil, mcSession != nil else {
            print("error: no mcPeerID or no mcSession, in browser foundPeer")
            return
        }
        if peerID.displayName == mcPeerIDDisplayName {
            browser.invitePeer(peerID, to: self.mcSession!, withContext: nil, timeout: 60)
        }
    }

    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) { print("MCNearbyServiceBrowser lostPeer \(peerID.displayName)") }

    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        print("MCNearbyServiceBrowser didNotStartBrowsingForPeers, error:")
        print(error)
    }
}
