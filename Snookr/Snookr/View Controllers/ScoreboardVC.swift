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
    var player1 = Player()
    var player2 = Player()
    let separatorView = SeparatorView()
    let stackView = ScoreboardStackView()
    let resetButton = SNKButton(title: "Next Frame", style: .outline)
    let tapRecognizer = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = SNKColor.background
        view.addSubviews(separatorView, stackView, resetButton)
        layout()
        setDelegates()
        setModels()
        setViews()
    }
    private func setDelegates() {
        stackView.scoreInfoView.playerNamesView.textView1.delegate = self
        stackView.scoreInfoView.playerNamesView.textView2.delegate = self
        stackView.scoreButtonsView.delegate = self
        stackView.scoreInfoView.undoButtonsView.delegate = self
    }
    private func setModels() {
        if let player1SavedName = defaults.value(forKey: Key.player1sName) { player1.name = player1SavedName as! String }
        if let player2SavedName = defaults.value(forKey: Key.player2sName) { player2.name = player2SavedName as! String }
        player1.score = 93
        player2.score = 12
        player1.lastScoreUpdate = 72
        player1.secondLastScoreUpdate = 3
        player1.thirdLastScoreUpdate = 9
        player2.lastScoreUpdate = 1
        player2.secondLastScoreUpdate = 1
        player2.thirdLastScoreUpdate = 4
    }
    private func setViews() {
        updatePlayerNameViews()
        updateScoreViews()
        stackView.scoreInfoView.scoreHistoryView.lastScoreUpdateLabel1.text = "+\(player1.lastScoreUpdate)"
        stackView.scoreInfoView.scoreHistoryView.secondLastScoreUpdateLabel1.text = "+\(player1.secondLastScoreUpdate)"
        stackView.scoreInfoView.scoreHistoryView.thirdLastScoreUpdateLabel1.text = "+\(player1.thirdLastScoreUpdate)"
        stackView.scoreInfoView.scoreHistoryView.lastScoreUpdateLabel2.text = "+\(player2.lastScoreUpdate)"
        stackView.scoreInfoView.scoreHistoryView.secondLastScoreUpdateLabel2.text = "+\(player2.secondLastScoreUpdate)"
        stackView.scoreInfoView.scoreHistoryView.thirdLastScoreUpdateLabel2.text = "+\(player2.thirdLastScoreUpdate)"
    }
    
}

//view updaters:
extension ScoreboardVC {
    private func updatePlayerNameViews() { stackView.scoreInfoView.playerNamesView.set(player1sName: player1.name, player2sName: player2.name) }
    func updateScoreViews() {
        stackView.scoreInfoView.scoresView.scoreLabel1.text = String(player1.score)
        stackView.scoreInfoView.scoresView.scoreLabel2.text = String(player2.score)
        stackView.scoreInfoView.scoresView.scoreDifView.set(difference: abs(player1.score - player2.score))
    }
    func updateScoreHistoryViewsOfPlayer1() {
        stackView.scoreInfoView.scoreHistoryView.lastScoreUpdateLabel1.text = "+\(player1.lastScoreUpdate)"
        stackView.scoreInfoView.scoreHistoryView.secondLastScoreUpdateLabel1.text = "+\(player1.secondLastScoreUpdate)"
        stackView.scoreInfoView.scoreHistoryView.thirdLastScoreUpdateLabel1.text = "+\(player1.thirdLastScoreUpdate)"
    }
    func updateScoreHistoryViewsOfPlayer2() {
        stackView.scoreInfoView.scoreHistoryView.lastScoreUpdateLabel2.text = "+\(player2.lastScoreUpdate)"
        stackView.scoreInfoView.scoreHistoryView.secondLastScoreUpdateLabel2.text = "+\(player2.secondLastScoreUpdate)"
        stackView.scoreInfoView.scoreHistoryView.thirdLastScoreUpdateLabel2.text = "+\(player2.thirdLastScoreUpdate)"
    }
}

//layout:
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
