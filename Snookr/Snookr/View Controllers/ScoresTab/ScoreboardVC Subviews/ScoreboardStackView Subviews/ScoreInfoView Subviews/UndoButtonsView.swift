//
//  UndoButtonsView.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/10/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit
import AVFoundation

protocol UndoButtonsViewDelegate: class {
    func didTapUndoButton(tag: Int)
    func didTapRedoButton(tag: Int)
}

class UndoButtonsView: UIView {
    
    weak var delegate: UndoButtonsViewDelegate!
    
    var undoButton1: SNKScoreButton!
    var undoButton2: SNKScoreButton!
    var redoButton1: SNKScoreButton!
    var redoButton2: SNKScoreButton!
    var soundPlayer: AVQueuePlayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        addButtonTargets()
        setInitialStateToHidden()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        undoButton1 = SNKScoreButton(normalSymbol: .undo, highlightedSymbol: .undoWithFill)
        undoButton2 = SNKScoreButton(normalSymbol: .undo, highlightedSymbol: .undoWithFill)
        redoButton1 = SNKScoreButton(normalSymbol: .redo, highlightedSymbol: .redoWithFill)
        redoButton2 = SNKScoreButton(normalSymbol: .redo, highlightedSymbol: .redoWithFill)
        redoButton1.tintColor = SNKColor.foregroundSecondary
        redoButton2.tintColor = SNKColor.foregroundSecondary
        addSubviews(undoButton1, undoButton2, redoButton1, redoButton2)
        NSLayoutConstraint.activate([
            undoButton1.topAnchor.constraint(equalTo: topAnchor),
            bottomAnchor.constraint(equalTo: undoButton1.bottomAnchor),
            undoButton1.leadingAnchor.constraint(equalTo: leadingAnchor),
            undoButton2.trailingAnchor.constraint(equalTo: trailingAnchor),
            redoButton1.leadingAnchor.constraint(equalTo: undoButton1.trailingAnchor, constant: SNKPadding.small),
            redoButton2.trailingAnchor.constraint(equalTo: undoButton2.leadingAnchor, constant: -SNKPadding.small)
        ])
    }
    
    private func addButtonTargets() {
        undoButton1.tag = SNKButtonTag.undoButton1
        undoButton2.tag = SNKButtonTag.undoButton2
        redoButton1.tag = SNKButtonTag.redoButton1
        redoButton2.tag = SNKButtonTag.redoButton2
        [undoButton1, undoButton2].forEach{ $0?.addTarget(self, action: #selector(didTapUndoButton(button:)), for: .touchUpInside)}
        [redoButton1, redoButton2].forEach{ $0?.addTarget(self, action: #selector(didTapRedoButton(button:)), for: .touchUpInside)}
    }
    @objc func didTapUndoButton(button: SNKScoreButton) {
//        AudioServicesPlaySystemSound(SNKSoundID.didTap)
        playSoundForTap(with: &soundPlayer)
        delegate.didTapUndoButton(tag: button.tag)
    }
    @objc func didTapRedoButton(button: SNKScoreButton) {
//        AudioServicesPlaySystemSound(SNKSoundID.didTap)
        playSoundForTap(with: &soundPlayer)
        delegate.didTapRedoButton(tag: button.tag)
    }
    
    private func setInitialStateToHidden() {
        [undoButton1, undoButton2, redoButton1, redoButton2].forEach { button in
            button?.isHidden = true
        }
    }
    
}
