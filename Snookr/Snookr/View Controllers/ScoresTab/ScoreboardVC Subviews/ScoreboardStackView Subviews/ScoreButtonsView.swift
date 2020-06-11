//
//  ScoreButtonsView.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/10/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit
import AVFoundation

protocol ScoreButtonsViewDelegate: class { func didTapScoreButton(tag: Int) }

class ScoreButtonsView: UIView {
    
    weak var delegate: ScoreButtonsViewDelegate!
    
    var plusButton1: SNKScoreButton!
    var plusButton2: SNKScoreButton!
    var plusOneButton1: SNKScoreButton!
    var plusOneButton2: SNKScoreButton!
    var soundPlayer: AVQueuePlayer?
    var soundOff: Bool!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureSoundSettings()
        addButtonTargets()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func configureSoundSettings() {
        soundOff = UserDefaults.standard.bool(forKey: SNKCommonKey.soundOff)
        NotificationCenter.default.addObserver(forName: .turnSoundOn, object: nil, queue: nil) { _ in
            self.soundOff = false
        }
        NotificationCenter.default.addObserver(forName: .turnSoundOff, object: nil, queue: nil) { _ in
            self.soundOff = true
        }
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        let plusButtonSize = (UIScreen.main.bounds.width - SNKPadding.big * 4 - SNKPadding.separatorViewWidth) / 2
        plusButton1 = SNKScoreButton(normalSymbol: .plusWithFill, highlightedSymbol: .plus, size: plusButtonSize, weight: .ultraLight)
        plusButton2 = SNKScoreButton(normalSymbol: .plusWithFill, highlightedSymbol: .plus, size: plusButtonSize, weight: .ultraLight)
        plusOneButton1 = SNKScoreButton(normalSymbol: .plus, highlightedSymbol: .plusWithFill)
        plusOneButton2 = SNKScoreButton(normalSymbol: .plus, highlightedSymbol: .plusWithFill)
        addSubviews(plusButton1, plusButton2, plusOneButton1, plusOneButton2)
        NSLayoutConstraint.activate([
            //vertical:
            plusButton1.topAnchor.constraint(equalTo: topAnchor),
            plusOneButton1.topAnchor.constraint(equalTo: plusButton1.bottomAnchor, constant: SNKPadding.negative),
            plusOneButton2.topAnchor.constraint(equalTo: plusButton1.bottomAnchor, constant: SNKPadding.negative),
            bottomAnchor.constraint(equalTo: plusOneButton1.bottomAnchor),
            //horizontal:
            plusButton1.centerXAnchor.constraint(equalTo: leadingAnchor, constant: (UIScreen.main.bounds.width-4*SNKPadding.big-SNKPadding.separatorViewWidth)/4 ),
            plusButton2.centerXAnchor.constraint(equalTo: trailingAnchor, constant: -(UIScreen.main.bounds.width-4*SNKPadding.big-SNKPadding.separatorViewWidth)/4 ),
            plusOneButton1.leadingAnchor.constraint(equalTo: leadingAnchor),
            plusOneButton2.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func addButtonTargets() {
        plusButton1.tag = SNKButtonTag.plusButton1
        plusButton2.tag = SNKButtonTag.plusButton2
        plusOneButton1.tag = SNKButtonTag.plusOneButton1
        plusOneButton2.tag = SNKButtonTag.plusOneButton2
        [plusButton1, plusButton2, plusOneButton1, plusOneButton2].forEach{ $0.addTarget(self, action: #selector(didTapScoreButton), for: .touchUpInside) }
    }
    
    @objc func didTapScoreButton(sender: SNKScoreButton) {
        if !soundOff { playSoundForTap(with: &soundPlayer) }
        delegate.didTapScoreButton(tag: sender.tag)
    }

}
