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
    
    let separatorLineView = UIView()
    var playerNameLabel1: SNKLabel!
    var playerNameLabel2: SNKLabel!
    let scoresView = ScoresView()
    let lastScoreUpdatesView = ScoreHistoryView()
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
        addPlayerNameLabels()
        view.addSubview(scoresView)
        view.addSubview(lastScoreUpdatesView)
        addUndoButtons()
        addPlusButtons()
        addPlusMinusOneButtons()
//        addWinFrameButtons() //not applicable in this lite version app
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
        lastScoreUpdatesView.lastScoreUpdateLabel1.text = "+\(player1.lastScoreUpdate)"
        lastScoreUpdatesView.secondLastScoreUpdateLabel1.text = "+\(player1.secondLastScoreUpdate)"
        lastScoreUpdatesView.thirdLastScoreUpdateLabel1.text = "+\(player1.thirdLastScoreUpdate)"
        lastScoreUpdatesView.lastScoreUpdateLabel2.text = "+\(player2.lastScoreUpdate)"
        lastScoreUpdatesView.secondLastScoreUpdateLabel2.text = "+\(player2.secondLastScoreUpdate)"
        lastScoreUpdatesView.thirdLastScoreUpdateLabel2.text = "+\(player2.thirdLastScoreUpdate)"
    }
    private func updateDataUponUserInput() {
    }
    
    private func addSeparatorLineView() {
        separatorLineView.backgroundColor = SNKColor.backgroundSecondary
        separatorLineView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(separatorLineView)
    }
    private func addPlayerNameLabels() {
        playerNameLabel1 = SNKLabel(fontSize: SNKFontSize.regular, fontWeight: SNKFontWeightForFontSize.regular, textAlignment: .left, numberOfLines: 2)
        playerNameLabel2 = SNKLabel(fontSize: SNKFontSize.regular, fontWeight: SNKFontWeightForFontSize.regular, textAlignment: .right, numberOfLines: 2)
        view.addSubviews(playerNameLabel1, playerNameLabel2)
    }
    private func addUndoButtons() {
        undoButton1 = SNKScoreButton(size: .small, symbol: .undo)
        undoButton2 = SNKScoreButton(size: .small, symbol: .undo)
        view.addSubviews(undoButton1, undoButton2)
    }
    private func addPlusButtons() {
        plusButtonSize = (view.bounds.width - SNKPadding.big * 4 - separatorWidth) / 2
        plusButton1 = SNKScoreButton(size: plusButtonSize, symbol: .plusWithFill)
        plusButton2 = SNKScoreButton(size: plusButtonSize, symbol: .plusWithFill)
        view.addSubviews(plusButton1, plusButton2)
    }
    private func addPlusMinusOneButtons() {
        minusOneButton1 = SNKScoreButton(size: .small, symbol: .minus)
        minusOneButton2 = SNKScoreButton(size: .small, symbol: .minus)
        plusOneButton1 = SNKScoreButton(size: .small, symbol: .plus)
        plusOneButton2 = SNKScoreButton(size: .small, symbol: .plus)
        view.addSubviews(minusOneButton1, minusOneButton2, plusOneButton1, plusOneButton2)
    }
    private func addWinFrameButtons() {
    }
    private func addResetButton() {
        resetButton = SNKButton(title: "Next frame", style: .outline)
        view.addSubview(resetButton)
    }
    
    private func layout() {
        let distBtwnViewEdgeAndPlusButtonCenterX = (view.bounds.width - separatorWidth - SNKPadding.big * 4) / 4 + SNKPadding.big
        NSLayoutConstraint.activate([
            resetButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -SNKPadding.big),
            resetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            resetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big),
            
            separatorLineView.widthAnchor.constraint(equalToConstant: separatorWidth),
            separatorLineView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            separatorLineView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: SNKPadding.big + 4),
            separatorLineView.bottomAnchor.constraint(equalTo: resetButton.topAnchor, constant: -SNKPadding.big),
            
            playerNameLabel1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: SNKPadding.big),
            playerNameLabel2.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: SNKPadding.big),
            playerNameLabel1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            playerNameLabel2.leadingAnchor.constraint(equalTo: separatorLineView.trailingAnchor, constant: SNKPadding.big),
            playerNameLabel1.trailingAnchor.constraint(equalTo: separatorLineView.leadingAnchor, constant: -SNKPadding.big),
            playerNameLabel2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big),
            
            scoresView.topAnchor.constraint(greaterThanOrEqualTo: playerNameLabel1.bottomAnchor, constant: SNKPadding.big * 2),
            scoresView.topAnchor.constraint(greaterThanOrEqualTo: playerNameLabel2.bottomAnchor, constant: SNKPadding.big),
            scoresView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scoresView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            lastScoreUpdatesView.topAnchor.constraint(equalTo: scoresView.bottomAnchor, constant: SNKPadding.big),
            lastScoreUpdatesView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            lastScoreUpdatesView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big),
            
            undoButton1.topAnchor.constraint(equalTo: lastScoreUpdatesView.bottomAnchor, constant: SNKPadding.tiny),
            undoButton2.topAnchor.constraint(equalTo: lastScoreUpdatesView.bottomAnchor, constant: SNKPadding.tiny),
            undoButton1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            undoButton2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big),
            
            plusButton1.topAnchor.constraint(equalTo: undoButton1.bottomAnchor, constant: SNKPadding.big * 2),
            plusButton2.topAnchor.constraint(equalTo: undoButton2.bottomAnchor, constant: SNKPadding.big * 2),
            plusButton1.centerXAnchor.constraint(equalTo: view.leadingAnchor, constant: distBtwnViewEdgeAndPlusButtonCenterX),
            plusButton2.centerXAnchor.constraint(equalTo: view.trailingAnchor, constant: -distBtwnViewEdgeAndPlusButtonCenterX),
            
            minusOneButton1.topAnchor.constraint(equalTo: plusButton1.bottomAnchor),
            minusOneButton2.topAnchor.constraint(equalTo: plusButton2.bottomAnchor),
            plusOneButton1.topAnchor.constraint(equalTo: plusButton1.bottomAnchor),
            plusOneButton2.topAnchor.constraint(equalTo: plusButton2.bottomAnchor),
            minusOneButton1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            plusOneButton1.trailingAnchor.constraint(equalTo: separatorLineView.leadingAnchor, constant: -SNKPadding.big),
            minusOneButton2.leadingAnchor.constraint(equalTo: separatorLineView.trailingAnchor, constant: SNKPadding.big),
            plusOneButton2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big)
        ])
    }
    
}
