//
//  UIViewController+.swift
//  Snookr
//
//  Created by Yinan Qiu on 6/2/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

@nonobjc extension UIViewController {
    
    func addAndConfigureChildVC(_ childVC: UIViewController, frame: CGRect? = nil) {
        addChild(childVC)
        if let frame = frame { childVC.view.frame = frame }
        view.addSubview(childVC.view)
        childVC.didMove(toParent: self)
    }
    
    func addAndConfigureChildVCSkipView(_ childVC: UIViewController, frame: CGRect? = nil) {
        addChild(childVC)
        if let frame = frame { childVC.view.frame = frame }
        childVC.didMove(toParent: self)
    }
    
    func removeAndClearFromParentVC() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }

}
