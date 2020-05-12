//
//  ScoreboardStackView.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/12/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class ScoreboardStackView: UIStackView {

    let scoreInfoView = ScoreInfoView()
    let scoreButtonsView = ScoreButtonsView()
    let spacerView = SpacerView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        distribution = .equalSpacing
        addArrangedSubviews(scoreInfoView, scoreButtonsView, spacerView)
    }

}
