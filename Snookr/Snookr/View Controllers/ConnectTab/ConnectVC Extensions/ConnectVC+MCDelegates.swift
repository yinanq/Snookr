//
//  ConnectVC+MCDelegates.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/20/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import MultipeerConnectivity

extension ConnectVC: MCSessionDelegate {
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        print("session didReceive data fromPeer \(peerID.displayName)")
        DispatchQueue.main.async {
            let jD = JSONDecoder()
            do {
                let decoded = try jD.decode(MCData.self, from: data)
                switch decoded.type {
                case SNKDataTypeForMC.name:
                    switch self.opponentIs {
                    case .player1:
                        self.mcUpdateName(of: &self.player1, to: decoded.name ?? "?")
                    case .player2:
                        self.mcUpdateName(of: &self.player2, to: decoded.name ?? "?")
                    }
                case SNKDataTypeForMC.frame:
                    print("frame!")
                case SNKDataTypeForMC.socre:
                    print("score!")
                default: print("error: invalid case of decoded.type, in session didReceive")
                }
            } catch {
                print("error: received data not decodable, in session didReceive.")
            }
        }
    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .connecting: print("peer \(peerID.displayName) is connecting")
        case .connected:
            print("peer \(peerID.displayName) is connected")
            DispatchQueue.main.async {
                self.mcStopConnectingButDontDisconnect()
                self.updateMCState(to: .isConnected)
            }
        case .notConnected:
            print("peer \(peerID.displayName) is not connected")
            DispatchQueue.main.async {
                self.mcDisconnect()
                self.updateMCState(to: .notConnected)
            }
        @unknown default: print("peer \(peerID.displayName) is in unknown state")
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) { print("session didReceive stream") }
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        print("session didStartReceivingResource")
    }
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        print("session didFinishReceivingResource")
    }
}


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
}
extension ConnectVC: MCNearbyServiceBrowserDelegate {
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        print("browser foundPeer \(peerID.displayName)")
        guard mcPeerID != nil, mcSession != nil else {
            print("error: no mcPeerID or no mcSession, in browser foundPeer")
            return
        }
        if peerID.displayName == mcPeerIDDisplayName {
            browser.invitePeer(peerID, to: self.mcSession!, withContext: nil, timeout: 60)
        }
    }
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) { print("browser lostPeer \(peerID.displayName)") }
}
