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
    }
    private func setViews() {
        updatePlayerNameView()
        updateScoresView()
        updateScoreHistoryView()
    }
    
}

//view updaters:
extension ScoreboardVC {
    private func updatePlayerNameView() { stackView.scoreInfoView.playerNamesView.set(player1sName: player1.name, player2sName: player2.name) }
    func updateScoresView() {
        stackView.scoreInfoView.scoresView.scoreLabel1.text = String(player1.score)
        stackView.scoreInfoView.scoresView.scoreLabel2.text = String(player2.score)
        stackView.scoreInfoView.scoresView.scoreDifView.set(difference: abs(player1.score - player2.score))
    }
    private func updateScoreHistoryView() {
        updateScoreHistoryViewAndUndoButtonsViewOfPlayer1()
        updateScoreHistoryViewAndUndoButtonsViewOfPlayer2()
    }
    func updateScoreHistoryViewAndUndoButtonsViewOfPlayer1() {
        if player1.lastScoreUpdate == nil && player1.secondLastScoreUpdate == nil && player1.thirdLastScoreUpdate == nil {
            stackView.scoreInfoView.undoButtonsView.undoButton1.isEnabled = false
        } else {
            stackView.scoreInfoView.undoButtonsView.undoButton1.isEnabled = true
        }
        if let lastScoreUpdate = player1.lastScoreUpdate {
            stackView.scoreInfoView.scoreHistoryView.lastScoreUpdateLabel1.text = "+\(lastScoreUpdate)"
        } else {
            stackView.scoreInfoView.scoreHistoryView.lastScoreUpdateLabel1.text = " "
        }
        if let secondLastScoreUpdate = player1.secondLastScoreUpdate {
            stackView.scoreInfoView.scoreHistoryView.secondLastScoreUpdateLabel1.text = "+\(secondLastScoreUpdate)"
        } else {
            stackView.scoreInfoView.scoreHistoryView.secondLastScoreUpdateLabel1.text = " "
        }
        if let thirdLastScoreUpdate = player1.thirdLastScoreUpdate {
            stackView.scoreInfoView.scoreHistoryView.thirdLastScoreUpdateLabel1.text = "+\(thirdLastScoreUpdate)"
        } else {
            stackView.scoreInfoView.scoreHistoryView.thirdLastScoreUpdateLabel1.text = " "
        }
    }
    func updateScoreHistoryViewAndUndoButtonsViewOfPlayer2() {
        if player2.lastScoreUpdate == nil && player2.secondLastScoreUpdate == nil && player2.thirdLastScoreUpdate == nil {
            stackView.scoreInfoView.undoButtonsView.undoButton2.isEnabled = false
        } else {
            stackView.scoreInfoView.undoButtonsView.undoButton2.isEnabled = true
        }
        if let lastScoreUpdate = player2.lastScoreUpdate {
            stackView.scoreInfoView.scoreHistoryView.lastScoreUpdateLabel2.text = "+\(lastScoreUpdate)"
        } else {
            stackView.scoreInfoView.scoreHistoryView.lastScoreUpdateLabel2.text = " "
        }
        if let secondLastScoreUpdate = player2.secondLastScoreUpdate {
            stackView.scoreInfoView.scoreHistoryView.secondLastScoreUpdateLabel2.text = "+\(secondLastScoreUpdate)"
        } else {
            stackView.scoreInfoView.scoreHistoryView.secondLastScoreUpdateLabel2.text = " "
        }
        if let thirdLastScoreUpdate = player2.thirdLastScoreUpdate {
            stackView.scoreInfoView.scoreHistoryView.thirdLastScoreUpdateLabel2.text = "+\(thirdLastScoreUpdate)"
        } else {
            stackView.scoreInfoView.scoreHistoryView.thirdLastScoreUpdateLabel2.text = " "
        }
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
