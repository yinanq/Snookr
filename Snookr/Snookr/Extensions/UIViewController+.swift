//
//  UIViewController+.swift
//  Snookr
//
//  Created by Yinan Qiu on 6/2/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit
import AVFoundation

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
    
    func playSoundForTap(with soundPlayer: inout AVQueuePlayer?) {
        guard let url = Bundle.main.url(forResource: "tap", withExtension: "m4a") else {
            print("error: did not find sound effect file")
            return
        }
        soundPlayer = AVQueuePlayer(url: url)
        soundPlayer?.play()
    }

}
