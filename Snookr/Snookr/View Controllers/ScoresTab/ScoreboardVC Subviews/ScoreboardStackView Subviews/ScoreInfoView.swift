//
//  ScoreInfoView.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/10/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class ScoreInfoView: UIView {
    
    let playerNamesView = PlayerNamesView()
    let scoresView = ScoresView()
    let scoreHistoryView = ScoreHistoryView()
    let undoButtonsView = UndoButtonsView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        let subviews = [playerNamesView, scoresView, scoreHistoryView, undoButtonsView]
        for subview in subviews {
            addSubview(subview)
            NSLayoutConstraint.activate([
                subview.leadingAnchor.constraint(equalTo: leadingAnchor),
                subview.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        }
        NSLayoutConstraint.activate([
            playerNamesView.topAnchor.constraint(equalTo: topAnchor),
            scoresView.topAnchor.constraint(equalTo: playerNamesView.bottomAnchor, constant: SNKPadding.small),
            scoreHistoryView.topAnchor.constraint(equalTo: scoresView.bottomAnchor, constant: SNKPadding.small),
            undoButtonsView.topAnchor.constraint(equalTo: scoreHistoryView.bottomAnchor, constant: SNKPadding.small),
            bottomAnchor.constraint(equalTo: undoButtonsView.bottomAnchor)
        ])
    }

}
