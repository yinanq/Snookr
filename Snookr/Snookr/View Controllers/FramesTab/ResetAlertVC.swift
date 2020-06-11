//
//  ResetAlertVC.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/21/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import AVFoundation

protocol ResetAlertVCDelegate: class { func didTapConfirmToReset() }

import UIKit

class ResetAlertVC: SNKAlertVC {
    
    weak var delegate: ResetAlertVCDelegate!
    
    var soundOff: Bool!
    
    init(title: String, body: String, cancelBtnTitle: String, confirmBtnTitile: String, delegate: ResetAlertVCDelegate) {
        super.init(title: title, body: body, cancelBtnTitle: cancelBtnTitle, confirmBtnTitile: confirmBtnTitile)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmButton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
        configureSoundSettings()
    }
    
    private func configureSoundSettings() {
        soundOff = UserDefaults.standard.bool(forKey: SNKCommonKey.soundOff)
        NotificationCenter.default.addObserver(forName: .turnSoundOn, object: nil, queue: nil) { _ in
            self.soundOff = false
        }
        NotificationCenter.default.addObserver(forName: .turnSoundOff, object: nil, queue: nil) { _ in
            self.soundOff = true
        }
    }
    
    @objc override func didTapConfirmButton() {
        super.didTapConfirmButton()
        delegate.didTapConfirmToReset()
        if !soundOff { playSoundForReset() }
    }
    
}
