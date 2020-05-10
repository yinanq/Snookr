//
//  ScoreboardVC.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/9/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class ScoreboardVC: UIViewController {
    
    var player1 = Player()
    var player2 = Player()
    
    let stackView = UIStackView()
    let playerNamesView = UIView()
    let scoreInfoView = UIView()
    let scoreButtonsView = UIView()
    let spacerView = UIView()
    
    let separatorLineView = UIView()
    var playerNameLabel1: SNKLabel!
    var playerNameLabel2: SNKLabel!
    let scoresView = ScoresView()
    let scoreHistoryView = ScoreHistoryView()
    var undoButton1: SNKScoreButton!
    var undoButton2: SNKScoreButton!
    var plusButton1: SNKScoreButton!
    var plusButton2: SNKScoreButton!
    var minusOneButton1: SNKScoreButton!
    var minusOneButton2: SNKScoreButton!
    var plusOneButton1: SNKScoreButton!
    var plusOneButton2: SNKScoreButton!
    
    var resetButton: SNKButton!
    
    let separatorWidth: CGFloat = 1
    var plusButtonSize: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = SNKColor.background
        
        addSeparatorLineView()
        
        addStackView()
        addScoreInfoView()
        addScoreButtonsView()
//        addWinFrameButtons() //not applicable in this lite version app
        addSpacerView()
        addResetButton()
        
        layout()
        
        readDataFromServer()
        writeDataFromServerToScoreboard()
        updateDataUponUserInput()
    }
    
    private func readDataFromServer() {
        player1.name = "Ronnie O'Sullivan"
        player2.name = "Yinan Qiu"
        player1.score = 93
        player2.score = 12
        player1.lastScoreUpdate = 72
        player1.secondLastScoreUpdate = 3
        player1.thirdLastScoreUpdate = 9
        player2.lastScoreUpdate = 1
        player2.secondLastScoreUpdate = 1
        player2.thirdLastScoreUpdate = 4
    }
    private func writeDataFromServerToScoreboard() {
        playerNameLabel1.text = player1.name
        playerNameLabel2.text = player2.name
        scoresView.scoreLabel1.text = String(player1.score)
        scoresView.scoreLabel2.text = String(player2.score)
        scoreHistoryView.lastScoreUpdateLabel1.text = "+\(player1.lastScoreUpdate)"
        scoreHistoryView.secondLastScoreUpdateLabel1.text = "+\(player1.secondLastScoreUpdate)"
        scoreHistoryView.thirdLastScoreUpdateLabel1.text = "+\(player1.thirdLastScoreUpdate)"
        scoreHistoryView.lastScoreUpdateLabel2.text = "+\(player2.lastScoreUpdate)"
        scoreHistoryView.secondLastScoreUpdateLabel2.text = "+\(player2.secondLastScoreUpdate)"
        scoreHistoryView.thirdLastScoreUpdateLabel2.text = "+\(player2.thirdLastScoreUpdate)"
    }
    private func updateDataUponUserInput() {
    }
    
    private func addStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        view.addSubview(stackView)
    }
    private func addSeparatorLineView() {
        separatorLineView.translatesAutoresizingMaskIntoConstraints = false
        separatorLineView.backgroundColor = SNKColor.backgroundSecondary
        view.addSubview(separatorLineView)
    }
    private func addPlayerNamesView() {
        playerNamesView.translatesAutoresizingMaskIntoConstraints = false
        playerNameLabel1 = SNKLabel(fontSize: SNKFontSize.regular, fontWeight: SNKFontWeightForFontSize.regular, textAlignment: .left, numberOfLines: 2)
        playerNameLabel2 = SNKLabel(fontSize: SNKFontSize.regular, fontWeight: SNKFontWeightForFontSize.regular, textAlignment: .right, numberOfLines: 2)
        playerNamesView.addSubviews(playerNameLabel1, playerNameLabel2)
        scoreInfoView.addSubview(playerNamesView)
    }
    private func addScoreInfoView() {
        addPlayerNamesView()
//        scoreInfoView.backgroundColor = .systemTeal
        undoButton1 = SNKScoreButton(size: .small, symbol: .undo)
        undoButton2 = SNKScoreButton(size: .small, symbol: .undo)
        scoreInfoView.addSubviews(scoresView, scoreHistoryView, undoButton1, undoButton2)
        stackView.addArrangedSubview(scoreInfoView)
    }
    private func addScoreButtonsView() {
//        scoreButtonsView.backgroundColor = .systemTeal
        plusButtonSize = (view.bounds.width - SNKPadding.big * 4 - separatorWidth) / 2
        plusButton1 = SNKScoreButton(size: plusButtonSize, symbol: .plusWithFill)
        plusButton2 = SNKScoreButton(size: plusButtonSize, symbol: .plusWithFill)
        minusOneButton1 = SNKScoreButton(size: .small, symbol: .minus)
        minusOneButton2 = SNKScoreButton(size: .small, symbol: .minus)
        plusOneButton1 = SNKScoreButton(size: .small, symbol: .plus)
        plusOneButton2 = SNKScoreButton(size: .small, symbol: .plus)
        scoreButtonsView.addSubviews(plusButton1, plusButton2, minusOneButton1, minusOneButton2, plusOneButton1, plusOneButton2)
        stackView.addArrangedSubview(scoreButtonsView)
    }
//    private func addWinFrameButtons() { } //not applicable in this lite version app
    private func addSpacerView() {
//        spacerView.backgroundColor = .systemTeal
        stackView.addArrangedSubview(spacerView)
    }
    private func addResetButton() {
        resetButton = SNKButton(title: "Next frame", style: .outline)
        view.addSubview(resetButton)
    }
    
    private func layout() {
        let distBtwnViewEdgeAndPlusButtonCenterX = (view.bounds.width - separatorWidth - SNKPadding.big * 4) / 4 + SNKPadding.big
        NSLayoutConstraint.activate([
            
            separatorLineView.widthAnchor.constraint(equalToConstant: separatorWidth),
            separatorLineView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            separatorLineView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 4),
            separatorLineView.bottomAnchor.constraint(equalTo: resetButton.topAnchor, constant: -SNKPadding.big),
            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: SNKPadding.big),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big),
            stackView.bottomAnchor.constraint(equalTo: resetButton.topAnchor, constant: -SNKPadding.big),

            scoreInfoView.heightAnchor.constraint(equalToConstant: 209),
            playerNamesView.topAnchor.constraint(equalTo: scoreInfoView.topAnchor),
            playerNamesView.heightAnchor.constraint(equalToConstant: 43),
            playerNamesView.leadingAnchor.constraint(equalTo: scoreInfoView.leadingAnchor),
            playerNamesView.trailingAnchor.constraint(equalTo: scoreInfoView.trailingAnchor),
            playerNameLabel1.leadingAnchor.constraint(equalTo: playerNamesView.leadingAnchor),
            playerNameLabel1.trailingAnchor.constraint(equalTo: separatorLineView.leadingAnchor, constant: -SNKPadding.big),
            playerNameLabel2.leadingAnchor.constraint(equalTo: separatorLineView.trailingAnchor, constant: SNKPadding.big),
            playerNameLabel2.trailingAnchor.constraint(equalTo: playerNamesView.trailingAnchor),
            scoresView.topAnchor.constraint(equalTo: playerNamesView.bottomAnchor, constant: SNKPadding.small),
            scoresView.leadingAnchor.constraint(equalTo: scoreInfoView.leadingAnchor),
            scoresView.trailingAnchor.constraint(equalTo: scoreInfoView.trailingAnchor),
            scoreHistoryView.topAnchor.constraint(equalTo: scoresView.bottomAnchor, constant: SNKPadding.small),
            scoreHistoryView.leadingAnchor.constraint(equalTo: scoreInfoView.leadingAnchor),
            scoreHistoryView.trailingAnchor.constraint(equalTo: scoreInfoView.trailingAnchor),
            undoButton1.topAnchor.constraint(equalTo: scoreHistoryView.bottomAnchor, constant: SNKPadding.tiny),
            undoButton2.topAnchor.constraint(equalTo: scoreHistoryView.bottomAnchor, constant: SNKPadding.tiny),
            undoButton1.leadingAnchor.constraint(equalTo: scoreInfoView.leadingAnchor),
            undoButton2.trailingAnchor.constraint(equalTo: scoreInfoView.trailingAnchor),

            scoreButtonsView.heightAnchor.constraint(equalToConstant: 207),
            plusButton1.topAnchor.constraint(equalTo: scoreButtonsView.topAnchor),
            plusButton2.topAnchor.constraint(equalTo: scoreButtonsView.topAnchor),
            plusButton1.centerXAnchor.constraint(equalTo: view.leadingAnchor, constant: distBtwnViewEdgeAndPlusButtonCenterX),
            plusButton2.centerXAnchor.constraint(equalTo: view.trailingAnchor, constant: -distBtwnViewEdgeAndPlusButtonCenterX),
            minusOneButton1.topAnchor.constraint(equalTo: plusButton1.bottomAnchor),
            minusOneButton2.topAnchor.constraint(equalTo: plusButton2.bottomAnchor),
            plusOneButton1.topAnchor.constraint(equalTo: plusButton1.bottomAnchor),
            plusOneButton2.topAnchor.constraint(equalTo: plusButton2.bottomAnchor),
            minusOneButton1.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            plusOneButton1.trailingAnchor.constraint(equalTo: separatorLineView.leadingAnchor, constant: -SNKPadding.big),
            minusOneButton2.leadingAnchor.constraint(equalTo: separatorLineView.trailingAnchor, constant: SNKPadding.big),
            plusOneButton2.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            spacerView.heightAnchor.constraint(equalToConstant: 20),
            
            resetButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -SNKPadding.big),
            resetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            resetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big)
        ])
    }
    
}
