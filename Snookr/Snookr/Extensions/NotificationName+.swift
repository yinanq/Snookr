//
//  NotificationName+.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/21/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import Foundation

extension Notification.Name {
    
    static let connectVCChangedCBState = Notification.Name("connectVCChangedCBState")
    static let connectVCChangedWhoswho = Notification.Name("connectVCChangedWhoswho")
    static let connectVCChangedNameOfPlayer1 = Notification.Name("connectVcChangedNameOfPlayer1")
    static let connectVCChangedNameOfPlayer2 = Notification.Name("connectVcChangedNameOfPlayer2")
    static let connectVCReceivedUpdatedScore = Notification.Name("connectVCReceivedUpdatedScore")
    static let connectVCReceivedUpdatedFrame = Notification.Name("connectVCReceivedUpdatedFrame")
    static let connectVCReceivedResetScores = Notification.Name("connectVCReceivedResetScores")
    static let connectVCReceivedResetFrames = Notification.Name("connectVCReceivedResetFrames")
    
    static let scoreboardVCChangedScoreOfEitherPlayer = Notification.Name("scoreboardVCChangedScoreOfEitherPlayer")
    static let scoreboardVCDidResetScores = Notification.Name("scoreboardVCDidResetScores")
    static let scoreboardVCChangedNameOfPlayer1 = Notification.Name("scoreboardVcChangedNameOfPlayer1")
    static let scoreboardVCChangedNameOfPlayer2 = Notification.Name("scoreboardVcChangedNameOfPlayer2")
    
    static let framesVCChangedFramesOfEitherPlayer = Notification.Name("framesVCChangedFramesOfEitherPlayer")
    static let framesVCDidResetFrames = Notification.Name("framesVCDidResetFrames")
    static let framesVCChangedNameOfPlayer1 = Notification.Name("framesVcChangedNameOfPlayer1")
    static let framesVCChangedNameOfPlayer2 = Notification.Name("framesVcChangedNameOfPlayer2")

}
