//
//  Constants.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/9/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

enum SNKAlpha {
    static let transparentHighOpacity: CGFloat = 0.6
    static let transparentMidOpacity: CGFloat = 0.4
    static let transparentLowOpacity: CGFloat = 0.2
}

enum SNKButtonSize {
    static let small: CGFloat = 42
}

enum SNKColor {
    static let background = UIColor(red: 36/255, green: 160/255, blue: 97/255, alpha: 1)
    static let backgroundSecondary = UIColor(red: 79/255, green: 179/255, blue: 128/255, alpha: 1)
    static let button = UIColor(white: 1, alpha: 1)
    static let text = UIColor(white: 1, alpha: 1)
}

enum SNKCornerRadius {
    static let big: CGFloat = 12
    static let small: CGFloat = 6
}

enum SNKFontSize {
    static let regular: CGFloat = 18
    static let small: CGFloat = 8
}

enum SNKFontWeightForFontSize {
    static let regular = UIFont.Weight.bold
    static let small = UIFont.Weight.semibold
}

enum SNKImage {
    static let undoButton = UIImage(systemName: "arrow.uturn.left.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: SNKButtonSize.small, weight: .ultraLight))
}

enum SNKPadding {
    static let big: CGFloat = 20
    static let small: CGFloat = 8
    static let tiny: CGFloat = 2
}
