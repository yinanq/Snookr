//
//  ScoreboardVC+InfoButtonViewDelegate.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/13/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

extension ScoreboardVC: InfoButtonViewDelegate {
    func didTapInfoButton() {
        let infoVC = InfoVC()
        infoVC.modalPresentationStyle = .fullScreen
        infoVC.modalTransitionStyle = .flipHorizontal
        present(infoVC, animated: true)
    }
}
