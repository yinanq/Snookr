//
//  ScoreboardVC+ScoreButtonsViewDelegate.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/12/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

extension ScoreboardVC: ScoreButtonsViewDelegate {

    func didTapScoreButton(tag: Int) {
        switch tag {
        case SNKButtonTag.plusButton1, SNKButtonTag.plusButton2: openPointsAdderVCForPlayerWith(buttonTag: tag)
        case SNKButtonTag.plusOneButton1, SNKButtonTag.plusOneButton2: addOneToScoreOfPlayerWith(buttonTag: tag)
        default: print("error: invalid tag, in didTapScoreButton")
        }
    }
    
    private func openPointsAdderVCForPlayerWith(buttonTag: Int) {
        var pointsAdderVC: PointsAdderVC!
        switch buttonTag {
        case SNKButtonTag.plusButton1: pointsAdderVC = PointsAdderVC(player: player1, delegate: self)
        case SNKButtonTag.plusButton2: pointsAdderVC = PointsAdderVC(player: player2, delegate: self)
        default: print("error: invalid tag in openPointsAdderVCForPlayerWith")
        }
        guard pointsAdderVC != nil else {
            print("error: pointsAdderVC is nil, in openPointsAdderVCForPlayerWith")
            return
        }
        present(pointsAdderVC, animated: true)
    }
    
    private func addOneToScoreOfPlayerWith(buttonTag: Int) {
        switch buttonTag {
        case SNKButtonTag.plusOneButton1: addOnePointFor(&player1)
        case SNKButtonTag.plusOneButton2: addOnePointFor(&player2)
        default: print("error: invalid tag, in addOneToScoreOfPlayer")
        }
        updateCommonViews()
    }
    private func addOnePointFor(_ player: inout Player) {
        player.score += 1
        persistScoreFor(&player)
        player.historyUndoable.append(1)
        updateScoreHistoryViewAndUndoButtonsViewFor(&player)
        keepUndoHistoryLimitFor(&player)
        clearRedoHistoryAndButtonFor(&player)
    }
    private func updateCommonViews() {
        updateScoresView()
        updateResetButton()
    }
    
}
