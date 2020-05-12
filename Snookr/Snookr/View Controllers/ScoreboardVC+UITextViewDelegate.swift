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
        textView.selectAll(self)
        view.addGestureRecognizer(tapRecognizer)
        let playerTag = textView.tag
        switch playerTag {
        case 1:
            disableAndDim(viewsToDimWhenEditingPlayerName1)
            tapRecognizer.addTarget(self, action: #selector(endEditingPlayerName1))
        case 2:
            disableAndDim(viewsToDimWhenEditingPlayerName2)
            tapRecognizer.addTarget(self, action: #selector(endEditingPlayerName2))
        default:
            print("error: wrong player tag in textViewDidBeginEditing")
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" { //"done" (return key) tapped, end editing:
            let playerTag = textView.tag
            switch playerTag {
            case 1:
                endEditingPlayerName1()
            case 2:
                endEditingPlayerName2()
            default:
                print("error: wrong player tag in shouldChangeTextIn")
            }
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
    
    private func setPlayerNameFromViewToModel(playerTag: Int) {
        switch playerTag {
        case SNKPlayerTag.player1:
            player1.name = stackView.scoreInfoView.playerNamesView.textView1.text
        case SNKPlayerTag.player2:
            player2.name = stackView.scoreInfoView.playerNamesView.textView2.text
        default:
            print("error: invalid player tag")
        }
    }
    
    private func disableAndDim(_ views: [UIView]) {
        views.forEach { view in
            view.isUserInteractionEnabled = false
            UIView.animate(withDuration: SNKAnimationDuration.short) { view.alpha = SNKAlpha.dimTo.rawValue }
        }
    }
    private func enableAndUndim(_ views: [UIView]) {
        views.forEach { view in
            view.isUserInteractionEnabled = true
            UIView.animate(withDuration: SNKAnimationDuration.short) { view.alpha = SNKAlpha.opaque.rawValue }
        }
    }
    
    @objc func endEditingPlayerName1() {
        view.removeGestureRecognizer(tapRecognizer)
        stackView.scoreInfoView.playerNamesView.textView1.resignFirstResponder()
        enableAndUndim(viewsToDimWhenEditingPlayerName1)
    }
    @objc func endEditingPlayerName2() {
        view.removeGestureRecognizer(tapRecognizer)
        stackView.scoreInfoView.playerNamesView.textView2.resignFirstResponder()
        enableAndUndim(viewsToDimWhenEditingPlayerName2)
    }
    
}
