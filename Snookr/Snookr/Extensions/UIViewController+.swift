//
//  UIViewController+.swift
//  Snookr
//
//  Created by Yinan Qiu on 6/2/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

@nonobjc extension UIViewController {
    
    func addChildVC(_ childVC: UIViewController, frame: CGRect? = nil) {
        addChild(childVC)
        if let frame = frame { childVC.view.frame = frame }
        view.addSubview(childVC.view)
        childVC.didMove(toParent: self)
    }
    
    func removeFromParentVC() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }

}
