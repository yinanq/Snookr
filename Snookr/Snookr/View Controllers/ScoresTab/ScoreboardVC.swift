//
//  ScoreboardVC.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/9/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

protocol ScoreboardVCDelegate: class {
    func scoreboardVCDidChangePlayer1NameTo(_ newName: String)
    func scoreboardVCDidChangePlayer2NameTo(_ newName: String)
}

class ScoreboardVC: UIViewController {
    
    weak var delegate: ScoreboardVCDelegate!
    
    let defaults = UserDefaults.standard
    
    enum Key {
        static let player1sName = SNKCommonKeys.player1sName
        static let player2sName = SNKCommonKeys.player2sName
        static let player1sScore = "1's score"
        static let player2sScore = "2's score"
    }
    
    var player1 = Player(playerId: .player1)
    var player2 = Player(playerId: .player2)
    
    let separatorView = SNKSeparatorView()
    let stackView = ScoreboardStackView()
    let resetButton = ResetButton()
    let tapRecognizer = UITapGestureRecognizer()
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = SNKColor.background
        view.addSubviews(separatorView, stackView, resetButton)
        layout()
        configureDelegates()
        configureModels()
        configureViews()
        playLaunchScreenSmootherAnimation()
    }
    
    private func configureDelegates() {
        stackView.scoreInfoView.playerNamesView.textView1.delegate = self
        stackView.scoreInfoView.playerNamesView.textView2.delegate = self
        stackView.scoreButtonsView.delegate = self
        stackView.scoreInfoView.undoButtonsView.delegate = self
        resetButton.delegate = self
    }
    
    private func configureModels() {
        player1.name = defaults.string(forKey: Key.player1sName) ?? SNKNamePlaceholder.player1
        player2.name = defaults.string(forKey: Key.player2sName) ?? SNKNamePlaceholder.player2
        player1.score = defaults.integer(forKey: Key.player1sScore)
        player2.score = defaults.integer(forKey: Key.player2sScore)
    }
    
    private func configureViews() {
        updatePlayerNamesView()
        updateScoresView()
        updateResetButton()
    }
    private func updatePlayerNamesView() { stackView.scoreInfoView.playerNamesView.set(player1sName: player1.name, player2sName: player2.name) }
    
    private func layout() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: SNKPadding.big),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big),
            stackView.bottomAnchor.constraint(equalTo: resetButton.topAnchor, constant: -SNKPadding.big),
            resetButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -SNKPadding.big),
            resetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            resetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big),
            separatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            separatorView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: SNKPadding.separatorViewTopAdj),
            separatorView.bottomAnchor.constraint(equalTo: resetButton.topAnchor, constant: -SNKPadding.big)
        ])
    }
    
}
