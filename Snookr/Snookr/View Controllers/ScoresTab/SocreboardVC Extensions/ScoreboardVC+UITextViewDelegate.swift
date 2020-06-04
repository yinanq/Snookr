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
        tapRecognizer.addTarget(view!, action: #selector(view.endEditing))
        textView.selectAll(self)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" { //"done" (return key) tapped, end editing:
            textView.resignFirstResponder()
            return false
        } else { //limit length of player name:
            let limit = SNKUserInputLimit.playerNameLengthLimit
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
        //if user entered empty string or string containing only empty space(s), set player name back to placdeholder:
        let text = textView.text! //appears never nil, so removed guard
        do {
            let regex = try NSRegularExpression(pattern: "^\\s*$")
            var placeholderName: String!
            switch textView.tag {
            case SNKTextViewTag.player1: placeholderName = SNKNamePlaceholder.player1
            case SNKTextViewTag.player2: placeholderName = SNKNamePlaceholder.player2
            default: print("invalid textView.tag, in textViewDidEndEditing, in ScoreboardVC: UITextViewDelegate")
            }
            textView.text = regex.stringByReplacingMatches(in: text, range: NSRange(text.startIndex..., in: text), withTemplate: placeholderName)
        } catch {
            print("error: invalid regex pattern")
            return
        }
        //update model and view:
        let textViewTag = textView.tag
        updateAndPersistPlayerNameModel(textViewTag: textViewTag)
        view.removeGestureRecognizer(tapRecognizer)
        enableAndUndimAll()
    }
    
    private func updateAndPersistPlayerNameModel(textViewTag: Int) {
        switch textViewTag {
        case SNKTextViewTag.player1:
            updatePlayerNameModel(player: &player1, newName: stackView.scoreInfoView.playerNamesView.textView1.text)
            defaults.set(player1.name, forKey: SNKCommonKey.player1sName)
            notifCtr.post(name: .scoreboardVCChangedNameOfPlayer1, object: player1.name)
        case SNKTextViewTag.player2:
            updatePlayerNameModel(player: &player2, newName: stackView.scoreInfoView.playerNamesView.textView2.text)
            defaults.set(player2.name, forKey: SNKCommonKey.player2sName)
            notifCtr.post(name: .scoreboardVCChangedNameOfPlayer2, object: player2.name)
        default: print("error: invalid player tag in setPlayerNameFromViewToModel")
        }
    }
    
    private func disableAndDimAllButNameOfPlayerTagged(_ playerTag: Int) {
        var viewsToDim: [UIView] = [separatorView, stackView.scoreInfoView.scoresView, stackView.scoreInfoView.scoreHistoryView, stackView.scoreInfoView.undoButtonsView, stackView.scoreButtonsView, resetButton]
        switch playerTag {
        case SNKTextViewTag.player1: viewsToDim.append(stackView.scoreInfoView.playerNamesView.textView2)
        case SNKTextViewTag.player2: viewsToDim.append(stackView.scoreInfoView.playerNamesView.textView1)
        default: print("error: invalid playerTag in disableAndDimAllButNameOfPlayer")
        }
        viewsToDim.forEach { view in
            view.isUserInteractionEnabled = false
            UIView.animate(withDuration: SNKAnimationDuration.short) { view.alpha = SNKAlpha.dimTo.rawValue }
        }
    }
    private func enableAndUndimAll() {
        let allViews: [UIView] = [separatorView, stackView.scoreInfoView.scoresView, stackView.scoreInfoView.scoreHistoryView, stackView.scoreInfoView.undoButtonsView, stackView.scoreButtonsView, resetButton, stackView.scoreInfoView.playerNamesView.textView1, stackView.scoreInfoView.playerNamesView.textView2]
        for view in allViews {
            view.isUserInteractionEnabled = true
            UIView.animate(withDuration: SNKAnimationDuration.short) { view.alpha = 1 }
        }
    }
    
}
