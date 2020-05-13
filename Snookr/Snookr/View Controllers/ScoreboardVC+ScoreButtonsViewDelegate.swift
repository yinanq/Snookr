//
//  ScoreboardVC+ScoreButtonsViewDelegate.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/12/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

extension ScoreboardVC: ScoreButtonsViewDelegate {
    func didTapButtonWith(tag: Int) {
        print(tag)
    }
}
