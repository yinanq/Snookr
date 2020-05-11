//
//  PlayerNamesView.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/10/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class PlayerNamesView: UIView {
    
//    //keep this code, in CAS version player name will be fixed labels not editable textviews:
//    var playerNameLabel1: SNKLabel!
//    var playerNameLabel2: SNKLabel!
    var textView1: SNKTextView!
    var textView2: SNKTextView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        configurePlayerNameTextFields()
//        configurePlayerNameLabels() //keep this code, in CAS version player name will be fixed labels not editable textviews
    }
    
    func set(player1sName: String, player2sName: String) {
        textView1.text = player1sName
        textView2.text = player2sName
    }
    
    private func configurePlayerNameTextFields() {
        textView1 = SNKTextView(fontSize: SNKFontSize.regular, fontWeight: SNKFontWeightForFontSize.regular, textAlignment: .left)
        textView2 = SNKTextView(fontSize: SNKFontSize.regular, fontWeight: SNKFontWeightForFontSize.regular, textAlignment: .right)
        addSubviews(textView1, textView2)
        NSLayoutConstraint.activate([
            textView1.topAnchor.constraint(equalTo: topAnchor),
            textView2.topAnchor.constraint(equalTo: topAnchor),
            textView1.leadingAnchor.constraint(equalTo: leadingAnchor),
            textView1.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -SNKPadding.big),
            textView2.leadingAnchor.constraint(equalTo: centerXAnchor, constant: SNKPadding.big),
            textView2.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomAnchor.constraint(greaterThanOrEqualTo: textView1.bottomAnchor),
            bottomAnchor.constraint(greaterThanOrEqualTo: textView2.bottomAnchor)
        ])
        backgroundColor = .systemTeal
        textView1.backgroundColor = .systemBlue
        textView2.backgroundColor = .systemBlue
    }
    
//    //keep this code, in CAS version player name will be fixed labels not editable textviews:
//    private func configurePlayerNameLabels() {
//        playerNameLabel1 = SNKLabel(fontSize: SNKFontSize.regular, fontWeight: SNKFontWeightForFontSize.regular, textAlignment: .left, numberOfLines: 2)
//        playerNameLabel2 = SNKLabel(fontSize: SNKFontSize.regular, fontWeight: SNKFontWeightForFontSize.regular, textAlignment: .right, numberOfLines: 2)
//        let playerNameLabels = [playerNameLabel1, playerNameLabel2]
//        for playerNameLabel in playerNameLabels {
//            addSubview(playerNameLabel!)
//            playerNameLabel!.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        }
//        NSLayoutConstraint.activate([
//            playerNameLabel1.leadingAnchor.constraint(equalTo: leadingAnchor),
//            playerNameLabel1.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -SNKPadding.big),
//            playerNameLabel2.leadingAnchor.constraint(equalTo: centerXAnchor, constant: SNKPadding.big),
//            playerNameLabel2.trailingAnchor.constraint(equalTo: trailingAnchor),
//            bottomAnchor.constraint(greaterThanOrEqualTo: playerNameLabel1.bottomAnchor),
//            bottomAnchor.constraint(greaterThanOrEqualTo: playerNameLabel2.bottomAnchor)
//        ])
//    }

}
