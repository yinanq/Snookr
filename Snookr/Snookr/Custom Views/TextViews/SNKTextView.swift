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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(fontSize: CGFloat, fontWeight: UIFont.Weight, textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        self.textAlignment = textAlignment
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        isScrollEnabled = false
        textColor = SNKColor.text
        tintColor = SNKColor.text
        backgroundColor = nil
        autocorrectionType = .no
        autocapitalizationType = .words
        returnKeyType = .done
    }
    
}
