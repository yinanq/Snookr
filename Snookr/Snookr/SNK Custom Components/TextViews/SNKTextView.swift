//
//  SNKTextView.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/11/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class SNKTextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        switch action {
        case #selector(copy(_:)):
            return super.canPerformAction(action, withSender: sender)
        case #selector(paste(_:)):
            return super.canPerformAction(action, withSender: sender)
        default:
            return false
        }
    }
    
    convenience init(fontSize: CGFloat, fontWeight: UIFont.Weight, textAlignment: NSTextAlignment = .center, textAndTintColor: UIColor = SNKColor.foreground) {
        self.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        textColor = textAndTintColor
        tintColor = textAndTintColor
        self.textAlignment = textAlignment
    }
    
    private func configure() {
        textContainer.lineFragmentPadding = 0
        textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        translatesAutoresizingMaskIntoConstraints = false
        isScrollEnabled = false
        backgroundColor = nil
        autocorrectionType = .no
        autocapitalizationType = .words
        returnKeyType = .done
    }
    
}
