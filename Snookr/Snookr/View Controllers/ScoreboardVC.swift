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
        addAndLayoutSubviews()
        setDelegates()
        setModel()
        setInitialDataFromModelToView()
    }
    
    private func setModel() {
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
    private func setPlayerNameFromViewToModel(playerTag: Int) {
        switch playerTag {
        case SNKPlayerTag.player1:
            player1.name = scoreInfoView.playerNamesView.textView1.text
        case SNKPlayerTag.player2:
            player2.name = scoreInfoView.playerNamesView.textView2.text
        default:
            print("error: invalid player tag")
        }
    }
    private func setDifferenceFromModelToView() { scoreInfoView.scoresView.scoreDifView.set(difference: abs(player1.score - player2.score) ) }
    
    private func addAndLayoutSubviews() {
        view.addSubview(separatorView)
        addStackView()
        addResetButton()
        layout()
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
    
    private func setDelegates() {
        scoreInfoView.playerNamesView.textView1.delegate = self
        scoreInfoView.playerNamesView.textView2.delegate = self
    }
    
}

extension ScoreboardVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" { //"done" (return key) tapped, end editing:
            textView.resignFirstResponder()
            return false
        } else { //limit length of player name:
            let limit = 25
            let string = (textView.text + text)
            if string.count <= limit {
                return true
            } else {
                textView.text = String(string[..<string.index(string.startIndex, offsetBy: limit)])
                return false
            }
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        let playerTag = textView.tag
        //if user entered empty string or string containing only empty space(s), set player name back to placdeholder:
        guard textView.text != nil else { //actually textView appears to always have text, never nil, but keeping guard here just to be safe
            textView.text = playerNamePlaceholder
            setPlayerNameFromViewToModel(playerTag: playerTag)
            return
        }
        let text = textView.text!
        do {
            let regex = try NSRegularExpression(pattern: "^\\s*$")
            textView.text = regex.stringByReplacingMatches(in: text, range: NSRange(text.startIndex..., in: text), withTemplate: playerNamePlaceholder)
        } catch {
            print("error: invalid regex pattern")
            return
        }
        setPlayerNameFromViewToModel(playerTag: playerTag)
    }
}
