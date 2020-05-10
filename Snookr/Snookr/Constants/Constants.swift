//
//  Constants.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/9/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

enum SNKAlpha: CGFloat {
    case opaque = 1
    case transparentHighOpacity = 0.6
    case transparentMidOpacity = 0.4
    case transparentLowOpacity = 0.2
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
    static let big: CGFloat = 24
    static let regular: CGFloat = 18
    static let small: CGFloat = 8
}

enum SNKFontWeightForFontSize {
    static let regular = UIFont.Weight.bold
    static let small = UIFont.Weight.semibold
}

enum SNKPadding {
    static let big: CGFloat = 20
    static let small: CGFloat = 8
    static let tiny: CGFloat = 2
}
