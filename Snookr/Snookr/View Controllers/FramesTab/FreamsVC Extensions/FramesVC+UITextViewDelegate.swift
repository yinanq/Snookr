//
//  FramesVC+UITextViewDelegate.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/18/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

extension FramesVC: UITextViewDelegate {
    
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
            let string = (textView.text + text)
            if string.count <= SNKPlayerNameLengthLimit {
                return true
            } else {
                textView.text = String(string[..<string.index(string.startIndex, offsetBy: SNKPlayerNameLengthLimit)])
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
            default: print("invalid textView.tag, in textViewDidEndEditing, in FramesVC: UITextViewDelegate")
            }
            textView.text = regex.stringByReplacingMatches(in: text, range: NSRange(text.startIndex..., in: text), withTemplate: placeholderName)
        } catch {
            print("error: invalid regex pattern, in FramesVC")
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
            player1.name = playerNamesView.textView1.text
            defaults.set(player1.name, forKey: Key.player1sName)
            notifCtr.post(name: .framesVCChangedNameOfPlayer1, object: player1.name)
        case SNKTextViewTag.player2:
            player2.name = playerNamesView.textView2.text
            defaults.set(player2.name, forKey: Key.player2sName)
            notifCtr.post(name: .framesVCChangedNameOfPlayer2, object: player2.name)
        default: print("error: invalid player tag in setPlayerNameFromViewToModel, in FramesVC")
        }
    }
    
    private func disableAndDimAllButNameOfPlayerTagged(_ playerTag: Int) {
        var viewsToDim: [UIView] = [separatorView, framesWonView, framesWonButtonsView, resetButton]
        switch playerTag {
        case SNKTextViewTag.player1: viewsToDim.append(playerNamesView.textView2)
        case SNKTextViewTag.player2: viewsToDim.append(playerNamesView.textView1)
        default: print("error: invalid playerTag in disableAndDimAllButNameOfPlayer, in FramesVC")
        }
        viewsToDim.forEach { view in
            view.isUserInteractionEnabled = false
            UIView.animate(withDuration: SNKAnimationDuration.short) { view.alpha = SNKAlpha.dimTo.rawValue }
        }
    }
    private func enableAndUndimAll() {
        let allViews: [UIView] = [separatorView, framesWonView, framesWonButtonsView, resetButton, playerNamesView.textView1, playerNamesView.textView2]
        for view in allViews {
            view.isUserInteractionEnabled = true
            UIView.animate(withDuration: SNKAnimationDuration.short) { view.alpha = 1 }
        }
        updateResetButton() //its alpha became 1 regardless, if was and is disabled then disable again to correct alpha
    }
    
}
