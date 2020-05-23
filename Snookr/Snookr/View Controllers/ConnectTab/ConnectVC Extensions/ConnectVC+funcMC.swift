//
//  ConnectVC+funcMC.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/22/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import MultipeerConnectivity

extension ConnectVC {
    
    func mcGeneratePeerID() {
        //to add guard when moved from testPeerIDUserCode to textField to be build
        mcPeerIDDisplayName = testPeerIDUserCode
        mcPeerID = MCPeerID(displayName: mcPeerIDDisplayName!)
        //to add persistence
    }
    
    func mcStartConnecting() {
        mcCreateSession()
        mcAdvertise()
        mcBrowse()
    }
    
    func mcStopConnectingButDontDisconnect() {
        mcAdvertiser?.stopAdvertisingPeer()
        mcBrowser?.stopBrowsingForPeers()
        mcAdvertiser = nil
        mcBrowser = nil
    }
    
    func mcDisconnect() {
        mcAdvertiser?.stopAdvertisingPeer()
        mcBrowser?.stopBrowsingForPeers()
        mcSession?.disconnect()
        mcAdvertiser = nil
        mcBrowser = nil
        mcSession = nil
    }
    
    private func mcCreateSession() {
        guard let peerID = mcPeerID else {
            print("error: no mcPeerID, in mcCreateSession")
            return
        }
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        mcSession?.delegate = self
    }
    private func mcAdvertise() {
        guard let peerID = mcPeerID else {
            print("error: no mcPeerID, in mcAdvertise")
            return
        }
        mcAdvertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: mcServiceType)
        mcAdvertiser?.delegate = self
        mcAdvertiser?.startAdvertisingPeer()
    }
    private func mcBrowse() {
        guard let peerID = mcPeerID else {
            print("error: no mcPeerID, in mcBrowse")
            return
        }
        mcBrowser = MCNearbyServiceBrowser(peer: peerID, serviceType: mcServiceType)
        mcBrowser?.delegate = self
        mcBrowser?.startBrowsingForPeers()
    }
    
}
