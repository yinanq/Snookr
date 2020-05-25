//
//  ConnectVC+MC.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/22/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import MultipeerConnectivity

extension ConnectVC {
    
    func updateMCState(to mcState: SNKmcState) {
        self.mcState = mcState
        pseudoPersistMCState()
        notifCtr.post(name: .connectVCChangedMCState, object: self.mcState)
        switch self.mcState {
        case .notConnected:
            unlockOpponentInfoEditability()
            meWhichPlayerView.unlockToggleButton()
            connectButton.setToConnectButton()
        case .isConnected:
            lockOpponentInfoEditability()
            meWhichPlayerView.lockToggleButton()
            connectButton.setToDisconnectButton()
        case .isConnecting:
            lockOpponentInfoEditability()
            meWhichPlayerView.lockToggleButton()
            connectButton.setToCancelButton()
        }
    }
    //like a global variable, for other VCs to first launch with correct mcState, but overwrite persisted value when app launches:
    func pseudoPersistMCState() { defaults.set(mcState.rawValue, forKey: SNKCommonKey.mcStateRawValue) }
    private func lockOpponentInfoEditability() {
        meWhichPlayerView.lockToggleButton()
        switch opponentIs {
        case .player1:
            playerNamesView.textView1.isEditable = false
        case .player2:
            playerNamesView.textView2.isEditable = false
        }
    }
    private func unlockOpponentInfoEditability() {
        meWhichPlayerView.unlockToggleButton()
        playerNamesView.textView1.isEditable = true
        playerNamesView.textView2.isEditable = true
    }
    
    func mcUpdateName(of player: inout Player, to newName: String) {
        updatePlayerNameModel(player: &player, newName: newName)
        updatePlayerNameView(for: player)
        switch player.playerId {
        case .player1:
            notifCtr.post(name: .connectVCChangedNameOfPlayer1, object: player.name)
            defaults.set(player.name, forKey: Key.player1sName)
        case .player2:
            notifCtr.post(name: .connectVCChangedNameOfPlayer2, object: player.name)
            defaults.set(player.name, forKey: Key.player2sName)
        case .unassigned: print("error: .unassigned playerId in mcUpdateName")
        }
    }
    
    func mcSend(snkDataTypeForMC: Int, name: String? = nil, frame: Int? = nil, score: Int? = nil, scoreHist1: Int? = nil, scoreHist2: Int? = nil, scoreHist3: Int? = nil) {
        let data = MCData(snkDataTypeForMC: snkDataTypeForMC, name: name, frame: frame, score: score, scoreHist1: scoreHist1, scoreHist2: scoreHist2, scoreHist3: scoreHist3)
        let jE = JSONEncoder()
        do {
            let encoded = try jE.encode(data)
            guard mcSession != nil else {
                print("error: no mcSession, in mcSend.")
                return
            }
            if mcSession!.connectedPeers.count > 0 {
                do {
                    try mcSession!.send(encoded, toPeers: mcSession!.connectedPeers, with: .reliable)
                } catch {
                    print("error: failed to send data, in mcSend, localizedDescription: \(error.localizedDescription).")
                }
            } else {
                print("error: has mcSession but no connectedPeers, in mcSend.")
            }
        } catch {
            print("error: encoding failed, in mcSend.")
        }
    }
    
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
