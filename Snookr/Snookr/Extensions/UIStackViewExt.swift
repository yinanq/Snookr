//
//  UIStackViewExt.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/10/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

extension UIStackView {
    
    func addArrangedSubviews(_ views: UIView...) {
        for view in views { addArrangedSubview(view) }
    }
    
}
