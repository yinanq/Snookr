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
    let undoButton1 = UIButton()
    let undoButton2 = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = SNKColor.background
        
        addSeparatorLineView()
        addPlayerNameLabels()
        view.addSubview(scoresView)
        view.addSubview(lastScoreUpdatesView)
        addUndoButtons()
        
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
        view.addSubview(playerNameLabel1)
        view.addSubview(playerNameLabel2)
    }
    private func addUndoButtons() {
        let undoButtons = [undoButton1, undoButton2]
        for undoButton in undoButtons {
            undoButton.translatesAutoresizingMaskIntoConstraints = false
            undoButton.setImage(SNKImage.undoButton, for: .normal)
            undoButton.tintColor = UIColor(white: 1, alpha: SNKAlpha.transparentHighOpacity)
            view.addSubview(undoButton)
        }
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            separatorLineView.widthAnchor.constraint(equalToConstant: 1),
            separatorLineView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            separatorLineView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: SNKPadding.big+4),
            separatorLineView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -SNKPadding.big),
            
            playerNameLabel1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: SNKPadding.big),
            playerNameLabel2.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: SNKPadding.big),
            playerNameLabel1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            playerNameLabel2.leadingAnchor.constraint(equalTo: separatorLineView.trailingAnchor, constant: SNKPadding.big),
            playerNameLabel1.trailingAnchor.constraint(equalTo: separatorLineView.leadingAnchor, constant: -SNKPadding.big),
            playerNameLabel2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big),
            
            scoresView.topAnchor.constraint(greaterThanOrEqualTo: playerNameLabel1.bottomAnchor, constant: SNKPadding.big*2),
            scoresView.topAnchor.constraint(greaterThanOrEqualTo: playerNameLabel2.bottomAnchor, constant: SNKPadding.big),
            scoresView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scoresView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            lastScoreUpdatesView.topAnchor.constraint(equalTo: scoresView.bottomAnchor, constant: SNKPadding.big),
            lastScoreUpdatesView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big),
            lastScoreUpdatesView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big),
            
            undoButton1.topAnchor.constraint(equalTo: lastScoreUpdatesView.bottomAnchor, constant: SNKPadding.tiny),
            undoButton2.topAnchor.constraint(equalTo: lastScoreUpdatesView.bottomAnchor, constant: SNKPadding.tiny),
            undoButton1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SNKPadding.big-2),
            undoButton2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SNKPadding.big+2)
        ])
    }
    
}
