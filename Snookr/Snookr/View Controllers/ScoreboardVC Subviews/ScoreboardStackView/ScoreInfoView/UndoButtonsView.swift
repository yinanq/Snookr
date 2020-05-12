//
//  UndoButtonsView.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/10/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class UndoButtonsView: UIView {
    
    var undoButton1: SNKScoreButton!
    var undoButton2: SNKScoreButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        undoButton1 = SNKScoreButton(size: .small, symbol: .undo)
        undoButton2 = SNKScoreButton(size: .small, symbol: .undo)
        addSubviews(undoButton1, undoButton2)
        NSLayoutConstraint.activate([
            undoButton1.topAnchor.constraint(equalTo: topAnchor),
            bottomAnchor.constraint(equalTo: undoButton1.bottomAnchor),
            undoButton1.leadingAnchor.constraint(equalTo: leadingAnchor),
            undoButton2.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
}
