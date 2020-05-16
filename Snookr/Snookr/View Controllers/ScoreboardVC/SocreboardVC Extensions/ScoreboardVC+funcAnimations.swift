//
//  ScoreboardVC+funcAnimations.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/16/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

//func animations:
extension ScoreboardVC {
    
    func playStarterAnimation() {
        view.alpha = 0
        UIView.animate(withDuration: SNKAnimationDuration.long, delay: 0, options: .curveEaseIn, animations: { self.view.alpha = 1 })
    }
    
}
