//
//  Constants.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/9/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

enum SNKAlpha: CGFloat {
    case disabledButton = 0.2
    case dimmer = 0.9
    case dimTo = 0.1
}

enum SNKAnimationDuration {
    static let short: TimeInterval = 0.2
    static let medium: TimeInterval = 0.8
    static let long: TimeInterval = 1.2
    static let launchSmootherDelay: TimeInterval = 1.47
    static let launchSmootherDuration: TimeInterval = 0.2
}

enum SNKButtonSize {
    static let small: CGFloat = 44
    static let smallerVisual: CGFloat = 30
}

enum SNKButtonTag {
    static let plusButton1 = 1
    static let plusButton2 = 2
    static let plusOneButton1 = 11
    static let plusOneButton2 = 12
    static let undoButton1 = -1
    static let undoButton2 = -2
    static let redoButton1 = -11
    static let redoButton2 = -12
}

enum SNKcbDataType {
    static let cbConnected = "cbConnected"
    static let cbDisconnected = "cbDisconnected"
    static let playerName = "playerName"
    static let frame = "frame"
    static let socre = "socre"
    static let resetFrame = "resetFrame"
    static let resetScore = "resetScore"
}

enum SNKcbState: Int {
    case notConnected = -1
    case isConnecting = 0
    case isConnected = 1
}

enum SNKCommonKey {
    static let cbStateRawValue = "cbStateRawValue"
    static let opponentIsRawValue = "opponentIsRawValue"
    static let player1sName = "player1sName"
    static let player2sName = "player2sName"
    static let player1sFrame = "player1sFrame"
    static let player2sFrame = "player2sFrame"
    static let player1sScore = "player1sScore"
    static let player2sScore = "player2sScore"
}

enum SNKColor {
    static let background = UIColor(white: 0, alpha: 1)
    static let backgroundSecondary = UIColor(red: 0/255, green: 52/255, blue: 30/255, alpha: 1)
    static let foreground = UIColor(red: 0/255, green: 255/255, blue: 147/255, alpha: 1)
    static let foregroundSecondary = UIColor(red: 0/255, green: 147/255, blue: 85/255, alpha: 1)
    static let foregroundTertiary = UIColor(red: 0/255, green: 88/255, blue: 50/255, alpha: 1)
    static let foregroundHighlited = UIColor(white: 1, alpha: 1)
    static let destructive = UIColor.systemPink
}

enum SNKCornerRadius {
    static let big: CGFloat = 10
    static let small: CGFloat = 5
}

enum SNKFontSize {
    static let gigantic: CGFloat = 120
    static let huge: CGFloat = 90
    static let big: CGFloat = 24
    static let regular: CGFloat = 18
    static let small: CGFloat = 8
}

enum SNKFontWeight {
    static let forFontSizeGigantic: UIFont.Weight = .semibold
    static let forFontSizeHuge: UIFont.Weight = .semibold
    static let forFontSizeRegular: UIFont.Weight = .bold
    static let forFontSizeSmall: UIFont.Weight = .bold
}

enum SNKBodyWidth {
    static let fixed: CGFloat = 347
    static let percent: CGFloat = 0.8
}

enum SNKNamePlaceholder {
//    static let player1 = "Opponent's Name"
//    static let player2 = "Your Name"
    static let player1 = "Enter Player Name"
    static let player2 = "Enter Player Name"
}

enum SNKPadding {
    static let big: CGFloat = 20
    static let small: CGFloat = 8
    static let tiny: CGFloat = 5
    static let negative: CGFloat = -5
    static let textViewAdjusterTop: CGFloat = -8
    static let textViewAdjusterTextAlignedSide: CGFloat = 3
    static let textViewAdjusterTextUnalignedSide: CGFloat = 9
    static let separatorViewWidth: CGFloat = 2
    static let separatorViewTopAdj: CGFloat = 4.5
    static let difViewWidth: CGFloat = 65
    static let lineSpacing: CGFloat = 10
}

enum SNKTabBarImage {
    static let connect = UIImage(systemName: "person.badge.plus.fill")
    static let connected = UIImage(systemName: "person.2.fill")
    static let scores = UIImage(systemName: "square.split.2x1.fill")
    static let frames = UIImage(systemName: "square.grid.3x2.fill")
    static let about = UIImage(systemName: "info.circle.fill")
}

enum SNKTabBarTitle {
    static let connect = "Connect"
    static let connected = "Connected"
    static let scores = "Scores"
    static let frames = "Frames"
    static let about = "About"
}

enum SNKTextViewTag {
    static let player1 = 1
    static let player2 = 2
}

enum SNKUserInputLimit {
    static let playerNameLengthLimit = 20
    static let connectCodeLengthLimit = 3
}

enum SNKWhichPlayer: Int {
    case player1 = 1
    case player2 = 2
}
