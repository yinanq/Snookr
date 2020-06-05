//
//  SNKPlayerNamesView.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/10/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class SNKPlayerNamesView: UIView {
    
    var textView1: SNKTextView!
    var textView2: SNKTextView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        configurePlayerNameTextFields()
    }
    
    func set(player1sName: String, player2sName: String) {
        textView1.text = player1sName
        textView2.text = player2sName
    }
    
    private func configurePlayerNameTextFields() {
        textView1 = SNKTextView(fontSize: SNKFontSize.regular, fontWeight: SNKFontWeight.forFontSizeRegular, textAlignment: .left)
        textView2 = SNKTextView(fontSize: SNKFontSize.regular, fontWeight: SNKFontWeight.forFontSizeRegular, textAlignment: .right)
        textView1.tag = SNKTextViewTag.player1
        textView2.tag = SNKTextViewTag.player2
        addSubviews(textView1, textView2)
        NSLayoutConstraint.activate([
            textView1.topAnchor.constraint(equalTo: topAnchor),
            textView2.topAnchor.constraint(equalTo: topAnchor),
            textView1.leadingAnchor.constraint(equalTo: leadingAnchor),
            textView1.trailingAnchor.constraint(equalTo: centerXAnchor, constant:  -SNKPadding.big + -SNKPadding.separatorViewWidth/2),
            textView2.leadingAnchor.constraint(equalTo: centerXAnchor, constant: SNKPadding.big + SNKPadding.separatorViewWidth/2),
            textView2.trailingAnchor.constraint(equalTo: trailingAnchor),
            heightAnchor.constraint(equalTo: textView1.heightAnchor),
            heightAnchor.constraint(equalTo: textView2.heightAnchor)
        ])
    }

}
