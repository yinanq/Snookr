//
//  UndoButtonsView.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/10/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

protocol UndoButtonsViewDelegate: class {
    func didTapUndoButton(tag: Int)
}

class UndoButtonsView: UIView {
    
    weak var delegate: UndoButtonsViewDelegate!
    
    var undoButton1: SNKScoreButton!
    var undoButton2: SNKScoreButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        addButtonTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        undoButton1 = SNKScoreButton(normalSymbol: .undo, highlightedSymbol: .undoWithFill)
        undoButton2 = SNKScoreButton(normalSymbol: .undo, highlightedSymbol: .undoWithFill)
        addSubviews(undoButton1, undoButton2)
        NSLayoutConstraint.activate([
            undoButton1.topAnchor.constraint(equalTo: topAnchor),
            bottomAnchor.constraint(equalTo: undoButton1.bottomAnchor),
            undoButton1.leadingAnchor.constraint(equalTo: leadingAnchor),
            undoButton2.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    private func addButtonTargets() {
        undoButton1.tag = SNKButtonTag.undoButton1
        undoButton2.tag = SNKButtonTag.undoButton2
        [undoButton1, undoButton2].forEach{ $0?.addTarget(self, action: #selector(didTapUndoButton), for: .touchUpInside)}
    }
    @objc func didTapUndoButton(sender: SNKScoreButton) { delegate.didTapUndoButton(tag: sender.tag) }
    
}
