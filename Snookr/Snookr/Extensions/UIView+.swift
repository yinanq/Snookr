//
//  UIView+.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/9/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit
import AVFoundation

@nonobjc extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
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
