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
        static let player1sLastScoreUpdate = "1's history 1"
        static let player1sSecondLastScoreUpdate = "1's history 2"
        static let player1sThirdLastScoreUpdate = "1's history 3"
        static let player2sLastScoreUpdate = "2's history 1"
        static let player2sSecondLastScoreUpdate = "2's history 2"
        static let player2sThirdLastScoreUpdate = "2's history 3"
    }
    var player1 = Player()
    var player2 = Player()
    let separatorView = SeparatorView()
    let stackView = ScoreboardStackView()
    let infoButton = SNKInfoButton()
    let resetButton = SNKButton(title: "Next Frame", style: .outline)
    let tapRecognizer = UITapGestureRecognizer()
    var viewsToDimWhenEditingPlayerName1 = [UIView]()
    var viewsToDimWhenEditingPlayerName2 = [UIView]()
    
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
        defaults.set(player1.name, forKey: Key.player1sName)
        defaults.set(player2.name, forKey: Key.player2sName)
    }
    
    private func setDelegates() {
        stackView.scoreInfoView.playerNamesView.textView1.delegate = self
        stackView.scoreInfoView.playerNamesView.textView2.delegate = self
    }
    
    func teste(){
        
    }
    
    private func setModel() {
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
    
    private func setInitialDataFromModelToView() {
        setPlayerNamesFromModelToView()
        stackView.scoreInfoView.scoresView.scoreLabel1.text = String(player1.score)
        stackView.scoreInfoView.scoresView.scoreLabel2.text = String(player2.score)
        setDifferenceFromModelToView()
        stackView.scoreInfoView.scoreHistoryView.lastScoreUpdateLabel1.text = "+\(player1.lastScoreUpdate)"
        stackView.scoreInfoView.scoreHistoryView.secondLastScoreUpdateLabel1.text = "+\(player1.secondLastScoreUpdate)"
        stackView.scoreInfoView.scoreHistoryView.thirdLastScoreUpdateLabel1.text = "+\(player1.thirdLastScoreUpdate)"
        stackView.scoreInfoView.scoreHistoryView.lastScoreUpdateLabel2.text = "+\(player2.lastScoreUpdate)"
        stackView.scoreInfoView.scoreHistoryView.secondLastScoreUpdateLabel2.text = "+\(player2.secondLastScoreUpdate)"
        stackView.scoreInfoView.scoreHistoryView.thirdLastScoreUpdateLabel2.text = "+\(player2.thirdLastScoreUpdate)"
    }
    private func setPlayerNamesFromModelToView() { stackView.scoreInfoView.playerNamesView.set(player1sName: player1.name, player2sName: player2.name) }
    private func setDifferenceFromModelToView() { stackView.scoreInfoView.scoresView.scoreDifView.set(difference: abs(player1.score - player2.score) ) }
    
    private func setSubviews() {
        view.addSubviews(separatorView, stackView, infoButton, resetButton)
        layout()
        selectViewsToDim()
    }
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
            infoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            infoButton.bottomAnchor.constraint(equalTo: resetButton.topAnchor, constant: -SNKPadding.big),
            resetButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -SNKPadding.big),
            resetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            resetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big)
        ])
    }
    private func selectViewsToDim() {
        let commonViewsToDim: [UIView] = [separatorView, stackView.scoreInfoView.scoresView, stackView.scoreInfoView.scoreHistoryView, stackView.scoreInfoView.undoButtonsView, stackView.scoreButtonsView, resetButton]
        viewsToDimWhenEditingPlayerName1.append(contentsOf: commonViewsToDim)
        viewsToDimWhenEditingPlayerName1.append(stackView.scoreInfoView.playerNamesView.textView2)
        viewsToDimWhenEditingPlayerName2.append(contentsOf: commonViewsToDim)
        viewsToDimWhenEditingPlayerName2.append(stackView.scoreInfoView.playerNamesView.textView1)
    }
    
}
