//
//  DisconnectAlertVC.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/26/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

protocol DisconnectAlertVCDelegate: class { func didTapConfirmToDisconnect() }

class DisconnectAlertVC: SNKAlertVC {
    
    weak var delegate: DisconnectAlertVCDelegate!
    
    init(title: String, body: String, cancelBtnTitle: String, confirmBtnTitile: String, delegate: DisconnectAlertVCDelegate) {
        super.init(title: title, body: body, cancelBtnTitle: cancelBtnTitle, confirmBtnTitile: confirmBtnTitile)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmButton.backgroundColor = SNKColor.destructive
        confirmButton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
    }
    
    @objc override func didTapConfirmButton() {
        super.didTapConfirmButton()
        delegate.didTapConfirmToDisconnect()
    }
    
}
