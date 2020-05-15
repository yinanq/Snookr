//
//  ScoreboardVC.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/9/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class ScoreboardVC: UIViewController {
    
    let defaults = UserDefaults.standard
    
    enum Key {
        static let player1sName = "1's name"
        static let player2sName = "2's name"
        static let player1sScore = "1's score"
        static let player2sScore = "2's score"
    }
    
    var player1 = Player(side: .left)
    var player2 = Player(side: .right)
    
    let separatorView = SeparatorView()
    let stackView = ScoreboardStackView()
    let resetButton = ResetButton()
    let tapRecognizer = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = SNKColor.background
        view.addSubviews(separatorView, stackView, resetButton)
        layout()
        configureDelegates()
        configureModels()
        configureViews()
    }
    
    private func configureDelegates() {
        stackView.scoreInfoView.playerNamesView.textView1.delegate = self
        stackView.scoreInfoView.playerNamesView.textView2.delegate = self
        stackView.scoreButtonsView.delegate = self
        stackView.scoreInfoView.undoButtonsView.delegate = self
        stackView.infoButtonView.delegate = self
        resetButton.delegate = self
    }
    
    private func configureModels() {
        if let player1SavedName = defaults.value(forKey: Key.player1sName) { player1.name = player1SavedName as! String }
        if let player2SavedName = defaults.value(forKey: Key.player2sName) { player2.name = player2SavedName as! String }
        if let player1SavedScore = defaults.value(forKey: Key.player1sScore) { player1.score = player1SavedScore as! Int }
        if let player2SavedScore = defaults.value(forKey: Key.player2sScore) { player2.score = player2SavedScore as! Int }
    }
    
    private func configureViews() {
        updatePlayerNameView()
        updateScoresView()
        updateResetButton()
    }
    
}

//private func view updaters:
extension ScoreboardVC {
    
    private func updatePlayerNameView() { stackView.scoreInfoView.playerNamesView.set(player1sName: player1.name, player2sName: player2.name) }

}

//private func layout:
extension ScoreboardVC {
    private func layout() {
        let separatorTopAjuster: CGFloat = 4
        let separatorBottomAdjuster: CGFloat = -4
        NSLayoutConstraint.activate([
            separatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            separatorView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: separatorTopAjuster),
            separatorView.bottomAnchor.constraint(equalTo: resetButton.topAnchor, constant: -SNKPadding.big + separatorBottomAdjuster),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: SNKPadding.big),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big),
            stackView.bottomAnchor.constraint(equalTo: resetButton.topAnchor, constant: -SNKPadding.big),
            resetButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -SNKPadding.big),
            resetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            resetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big)
        ])
    }
}
