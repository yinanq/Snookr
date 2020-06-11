//
//  FramesWonButtonsView.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/18/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit
import AVFoundation

protocol FramesWonButtonsViewDelegate: class { func didTapFramesWonButton(withTag: Int) }

class FramesWonButtonsView: UIView {
    
    weak var delegate: FramesWonButtonsViewDelegate!
    
    var plusOneButton1: SNKScoreButton!
    var plusOneButton2: SNKScoreButton!
    var minusOneButton1: SNKScoreButton!
    var minusOneButton2: SNKScoreButton!
    var soundPlayer: AVQueuePlayer?
    var soundOff: Bool!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureSoundSettings()
        addButtonTargets()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        plusOneButton1 = SNKScoreButton(normalSymbol: .plus, highlightedSymbol: .plusWithFill)
        plusOneButton2 = SNKScoreButton(normalSymbol: .plus, highlightedSymbol: .plusWithFill)
        minusOneButton1 = SNKScoreButton(normalSymbol: .minus, highlightedSymbol: .minusWithFill)
        minusOneButton2 = SNKScoreButton(normalSymbol: .minus, highlightedSymbol: .minusWithFill)
        addSubviews(plusOneButton1, plusOneButton2, minusOneButton1, minusOneButton2)
        
        NSLayoutConstraint.activate([
            //vertical:
            plusOneButton1.topAnchor.constraint(equalTo: topAnchor),
            bottomAnchor.constraint(equalTo: plusOneButton1.bottomAnchor),
            //left:
            minusOneButton1.leadingAnchor.constraint(equalTo: leadingAnchor),
            plusOneButton1.leadingAnchor.constraint(equalTo: minusOneButton1.trailingAnchor, constant: SNKPadding.small),
            //right:
            plusOneButton2.trailingAnchor.constraint(equalTo: trailingAnchor),
            minusOneButton2.trailingAnchor.constraint(equalTo: plusOneButton2.leadingAnchor, constant: -SNKPadding.small)
        ])
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
    
    private func addButtonTargets() {
        plusOneButton1.tag = 1
        plusOneButton2.tag = 2
        minusOneButton1.tag = -1
        minusOneButton2.tag = -2
        [plusOneButton1, plusOneButton2, minusOneButton1, minusOneButton2].forEach { button in
            button?.addTarget(self, action: #selector(didTapFramesWonButton(sender:)), for: .touchUpInside)
        }
    }
    
    @objc func didTapFramesWonButton(sender: SNKScoreButton) {
        if !soundOff { playSoundForTap(with: &soundPlayer) }
        delegate.didTapFramesWonButton(withTag: sender.tag)
    }

}
