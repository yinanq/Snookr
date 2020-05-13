//
//  ScoreboardVC+UITextViewDelegate.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/11/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

extension ScoreboardVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        disableAndDimAllButNameOfPlayerTagged(textView.tag)
        view.addGestureRecognizer(tapRecognizer)
        tapRecognizer.addTarget(self.view!, action: #selector(view.endEditing))
        textView.selectAll(self)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" { //"done" (return key) tapped, end editing:
            view.endEditing(false)
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
        view.removeGestureRecognizer(tapRecognizer)
        enableAndUndimAll()
        let playerTag = textView.tag
        //if user entered empty string or string containing only empty space(s), set player name back to placdeholder:
        guard textView.text != nil else { //actually textView appears to always have text, never nil, but keeping guard here just to be safe
            textView.text = playerNamePlaceholder
            updatePlayerNameModel(playerTag: playerTag)
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
        updatePlayerNameModel(playerTag: playerTag)
    }
    
    private func updatePlayerNameModel(playerTag: Int) {
        switch playerTag {
        case SNKPlayerTag.player1:
            player1.name = stackView.scoreInfoView.playerNamesView.textView1.text
            defaults.set(player1.name, forKey: Key.player1sName)
        case SNKPlayerTag.player2:
            player2.name = stackView.scoreInfoView.playerNamesView.textView2.text
            defaults.set(player2.name, forKey: Key.player2sName)
        default: print("error: invalid player tag in setPlayerNameFromViewToModel")
        }
    }
    
    private func disableAndDimAllButNameOfPlayerTagged(_ playerTag: Int) {
        var viewsToDim: [UIView] = [separatorView, stackView.scoreInfoView.scoresView, stackView.scoreInfoView.scoreHistoryView, stackView.scoreInfoView.undoButtonsView, stackView.scoreButtonsView, resetButton]
        switch playerTag {
        case 1: viewsToDim.append(stackView.scoreInfoView.playerNamesView.textView2)
        case 2: viewsToDim.append(stackView.scoreInfoView.playerNamesView.textView1)
        default: print("error: invalid playerTag in disableAndDimAllButNameOfPlayer")
        }
        viewsToDim.forEach { view in
            view.isUserInteractionEnabled = false
            UIView.animate(withDuration: SNKAnimationDuration.short) { view.alpha = SNKAlpha.dimTo.rawValue }
        }
    }
    private func enableAndUndimAll() {
        let allViews: [UIView] = [separatorView, stackView.scoreInfoView.scoresView, stackView.scoreInfoView.scoreHistoryView, stackView.scoreInfoView.undoButtonsView, stackView.scoreButtonsView, resetButton, stackView.scoreInfoView.playerNamesView.textView1, stackView.scoreInfoView.playerNamesView.textView2]
        allViews.forEach { view in
            view.isUserInteractionEnabled = true
            UIView.animate(withDuration: SNKAnimationDuration.short) { view.alpha = SNKAlpha.opaque.rawValue }
        }
    }
    
}
