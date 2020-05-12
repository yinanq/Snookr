//
//  ScoreboardVC.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/9/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

enum playerNameKey: String {
    case player1 = "player 1's name"
    case player2 = "player 2's name"
}

class ScoreboardVC: UIViewController {
    
    let defaults = UserDefaults.standard
    
    var player1 = Player()
    var player2 = Player()
    
    let separatorView = SeparatorView()
    
    let stackView = UIStackView()
    let scoreInfoView = ScoreInfoView()
    var scoreButtonsView = ScoreButtonsView()
    let spacerView = SpacerView()
    
    var resetButton: SNKButton!
    
    var viewsToDimWhenEditingPlayerName1 = [UIView]()
    var viewsToDimWhenEditingPlayerName2 = [UIView]()
    let tapRecognizer = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = SNKColor.background
        setSubviews()
        setDelegates()
        setModel()
        setInitialDataFromModelToView()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        defaults.set(player1.name, forKey: playerNameKey.player1.rawValue)
        defaults.set(player2.name, forKey: playerNameKey.player2.rawValue)
    }
    
    private func setDelegates() {
        scoreInfoView.playerNamesView.textView1.delegate = self
        scoreInfoView.playerNamesView.textView2.delegate = self
    }
    
    private func setModel() {
        if let player1SavedName = defaults.value(forKey: playerNameKey.player1.rawValue) { player1.name = player1SavedName as! String }
        if let player2SavedName = defaults.value(forKey: playerNameKey.player2.rawValue) { player2.name = player2SavedName as! String }
        player1.score = 93
        player2.score = 12
        player1.lastScoreUpdate = 72
        player1.secondLastScoreUpdate = 3
        player1.thirdLastScoreUpdate = 9
        player2.lastScoreUpdate = 1
        player2.secondLastScoreUpdate = 1
        player2.thirdLastScoreUpdate = 4
    }
    
    private func setInitialDataFromModelToView() {
        setPlayerNamesFromModelToView()
        scoreInfoView.scoresView.scoreLabel1.text = String(player1.score)
        scoreInfoView.scoresView.scoreLabel2.text = String(player2.score)
        setDifferenceFromModelToView()
        scoreInfoView.scoreHistoryView.lastScoreUpdateLabel1.text = "+\(player1.lastScoreUpdate)"
        scoreInfoView.scoreHistoryView.secondLastScoreUpdateLabel1.text = "+\(player1.secondLastScoreUpdate)"
        scoreInfoView.scoreHistoryView.thirdLastScoreUpdateLabel1.text = "+\(player1.thirdLastScoreUpdate)"
        scoreInfoView.scoreHistoryView.lastScoreUpdateLabel2.text = "+\(player2.lastScoreUpdate)"
        scoreInfoView.scoreHistoryView.secondLastScoreUpdateLabel2.text = "+\(player2.secondLastScoreUpdate)"
        scoreInfoView.scoreHistoryView.thirdLastScoreUpdateLabel2.text = "+\(player2.thirdLastScoreUpdate)"
    }
    private func setPlayerNamesFromModelToView() { scoreInfoView.playerNamesView.set(player1sName: player1.name, player2sName: player2.name) }
    private func setDifferenceFromModelToView() { scoreInfoView.scoresView.scoreDifView.set(difference: abs(player1.score - player2.score) ) }
    
    private func setSubviews() {
        view.addSubview(separatorView)
        addStackView()
        addResetButton()
        layout()
        selectViewsToDim()
    }
    private func addStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubviews(scoreInfoView, scoreButtonsView, spacerView)
        view.addSubview(stackView)
    }
    private func addResetButton() {
        resetButton = SNKButton(title: "Next frame", style: .outline)
        view.addSubview(resetButton)
    }
    private func layout() {
        NSLayoutConstraint.activate([
            separatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            separatorView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 4),
            separatorView.bottomAnchor.constraint(equalTo: resetButton.topAnchor, constant: -SNKPadding.big),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: SNKPadding.big),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big),
            stackView.bottomAnchor.constraint(equalTo: resetButton.topAnchor, constant: -SNKPadding.big),
            resetButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -SNKPadding.big),
            resetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            resetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big)
        ])
    }
    private func selectViewsToDim() {
        let commonViewsToDim: [UIView] = [separatorView, scoreInfoView.scoresView, scoreInfoView.scoreHistoryView, scoreInfoView.undoButtonsView, scoreButtonsView, resetButton]
        viewsToDimWhenEditingPlayerName1.append(contentsOf: commonViewsToDim)
        viewsToDimWhenEditingPlayerName1.append(scoreInfoView.playerNamesView.textView2)
        viewsToDimWhenEditingPlayerName2.append(contentsOf: commonViewsToDim)
        viewsToDimWhenEditingPlayerName2.append(scoreInfoView.playerNamesView.textView1)
    }
    
}
