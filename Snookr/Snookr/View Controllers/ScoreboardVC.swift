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
    
    let separatorView = SeparatorView()
    
    let stackView = UIStackView()
    let scoreInfoView = ScoreInfoView()
    var scoreButtonsView = ScoreButtonsView()
    let spacerView = SpacerView()
    
    var resetButton: SNKButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = SNKColor.background
        
        view.addSubview(separatorView)
        addStackView()
        addResetButton()
        
        layout()
        
        readDataFromServer()
        writeDataFromServerToScoreboard()
        
        updatePlayerNames()
        updateScore()
    }
    
    private func updatePlayerNames() {
        scoreInfoView.playerNamesView.set(player1sName: player1.name, player2sName: player2.name)
        scoreInfoView.playerNamesView.textView1.delegate = self
        scoreInfoView.playerNamesView.textView2.delegate = self
//        //keep this code, in CAS version player name will be fixed labels not editable textviews:
//        scoreInfoView.playerNamesView.playerNameLabel1.text = player1.name
//        scoreInfoView.playerNamesView.playerNameLabel2.text = player2.name
    }
    
    private func updateScore() {
        updateDifference()
    }
    
    private func updateDifference() { scoreInfoView.scoresView.scoreDifView.set(difference: abs(player1.score - player2.score) ) }
    
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
    
    private func readDataFromServer() {
//        player1.name = "Ronnie O'Sullivan"
//        player2.name = "Yinan Qiu"
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
        scoreInfoView.scoresView.scoreLabel1.text = String(player1.score)
        scoreInfoView.scoresView.scoreLabel2.text = String(player2.score)
        scoreInfoView.scoreHistoryView.lastScoreUpdateLabel1.text = "+\(player1.lastScoreUpdate)"
        scoreInfoView.scoreHistoryView.secondLastScoreUpdateLabel1.text = "+\(player1.secondLastScoreUpdate)"
        scoreInfoView.scoreHistoryView.thirdLastScoreUpdateLabel1.text = "+\(player1.thirdLastScoreUpdate)"
        scoreInfoView.scoreHistoryView.lastScoreUpdateLabel2.text = "+\(player2.lastScoreUpdate)"
        scoreInfoView.scoreHistoryView.secondLastScoreUpdateLabel2.text = "+\(player2.secondLastScoreUpdate)"
        scoreInfoView.scoreHistoryView.thirdLastScoreUpdateLabel2.text = "+\(player2.thirdLastScoreUpdate)"
    }
    
}

extension ScoreboardVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //if "done" (return key) tapped, end editing:
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        } else {
            //limit length of player name:
            let limit = 25
            let str = (textView.text + text)
            if str.count <= limit {
                return true
            } else {
                textView.text = String(str[..<str.index(str.startIndex, offsetBy: limit)])
                return false
            }
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        //if user entered empty string or string containing only empty space(s), set player name back to placdeholder:
        //actually textView appears to always have text, never nil, but keeping guard here just to be safe:
        guard textView.text != nil else {
            textView.text = playerNamePlaceholder
            return
        }
        let text = textView.text!
        do {
            let regex = try NSRegularExpression(pattern: "^\\s*$")
            textView.text = regex.stringByReplacingMatches(in: text, range: NSRange(text.startIndex..., in: text), withTemplate: playerNamePlaceholder)
        } catch {
            return
        }
    }
}
