//
//  ResetAlertVC.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/21/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

protocol ResetAlertVCDelegate: class {
    func didTapConfirmToReset()
}

import UIKit

class ResetAlertVC: SNKAlertVC {
    
    weak var delegate: ResetAlertVCDelegate!
    
    init(title: String, body: String, cancelBtnTitle: String, confirmBtnTitile: String, delegate: ResetAlertVCDelegate) {
        super.init(title: title, body: body, cancelBtnTitle: cancelBtnTitle, confirmBtnTitile: confirmBtnTitile)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmButton.addTarget(self, action: #selector(didTapConfirmResetButton), for: .touchUpInside)
    }
    
    @objc override func didTapConfirmResetButton() {
        dismiss(animated: true) {
            self.delegate.didTapConfirmToReset()
        }
    }
    
}
