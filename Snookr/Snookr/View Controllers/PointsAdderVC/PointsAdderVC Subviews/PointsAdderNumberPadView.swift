//
//  PointsAdderNumberPadView.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/13/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

protocol PointsAdderNumberPadViewDelegate: class {
    func didTapNumberPad(buttonTag: Int)
}

class PointsAdderNumberPadView: UIView {
    
    weak var delegate: PointsAdderNumberPadViewDelegate!
    
    var key1: SNKNumberPadButton!
    var key2: SNKNumberPadButton!
    var key3: SNKNumberPadButton!
    var key4: SNKNumberPadButton!
    var key5: SNKNumberPadButton!
    var key6: SNKNumberPadButton!
    var key7: SNKNumberPadButton!
    var key8: SNKNumberPadButton!
    var key9: SNKNumberPadButton!
    var key0: SNKNumberPadButton!
    var keyDelete: SNKNumberPadButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        initializeKeys()
        [key1, key2, key1, key2, key3, key4, key5, key6, key7, key8, key9, key0, keyDelete].forEach { key in
            addSubview(key!)
            key!.addTarget(self, action: #selector(didTapNumberPad(sender:)), for: .touchUpInside)
        }
        layoutKeys()
        keyDelete.isHidden = true
    }
    
    @objc func didTapNumberPad(sender: SNKNumberPadButton) { delegate.didTapNumberPad(buttonTag: sender.tag) }
    
    private func initializeKeys() {
        key1 = SNKNumberPadButton(normalSymbol: .k1, highlightedSymbol: .k1F)
        key2 = SNKNumberPadButton(normalSymbol: .k2, highlightedSymbol: .k2F)
        key3 = SNKNumberPadButton(normalSymbol: .k3, highlightedSymbol: .k3F)
        key4 = SNKNumberPadButton(normalSymbol: .k4, highlightedSymbol: .k4F)
        key5 = SNKNumberPadButton(normalSymbol: .k5, highlightedSymbol: .k5F)
        key6 = SNKNumberPadButton(normalSymbol: .k6, highlightedSymbol: .k6F)
        key7 = SNKNumberPadButton(normalSymbol: .k7, highlightedSymbol: .k7F)
        key8 = SNKNumberPadButton(normalSymbol: .k8, highlightedSymbol: .k8F)
        key9 = SNKNumberPadButton(normalSymbol: .k9, highlightedSymbol: .k9F)
        key0 = SNKNumberPadButton(normalSymbol: .k0, highlightedSymbol: .k0F)
        keyDelete = SNKNumberPadButton(normalSymbol: .delete, highlightedSymbol: .deleteF, size: SNKButtonSize.smallerVisual, weight: .light, contentMode: .center)
        key1.tag = 1
        key2.tag = 2
        key3.tag = 3
        key4.tag = 4
        key5.tag = 5
        key6.tag = 6
        key7.tag = 7
        key8.tag = 8
        key9.tag = 9
        key0.tag = 0
        keyDelete.tag = -1
    }
    
    private func layoutKeys() {
        let gapSize: CGFloat = 1
        [key1, key2, key1, key2, key3, key4, key5, key6, key7, key8, key9, key0].forEach { key in
            key!.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 2*SNKPadding.big - 2*gapSize) / 3).isActive = true
            key!.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/4, constant: -3*gapSize/4).isActive = true
        }
        [key1, key2, key3].forEach { key in
            key.topAnchor.constraint(equalTo: topAnchor).isActive = true
        }
        [key4, key5, key6].forEach { key in
            key.topAnchor.constraint(equalTo: key1.bottomAnchor, constant: gapSize).isActive = true
        }
        [key7, key8, key9].forEach { key in
            key.topAnchor.constraint(equalTo: key4.bottomAnchor, constant: gapSize).isActive = true
        }
        key0.topAnchor.constraint(equalTo: key7.bottomAnchor, constant: gapSize).isActive = true
        [key1, key4, key7].forEach { key in
            key.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        }
        [key2, key5, key8, key0].forEach { key in
            key.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        }
        [key3, key6, key9].forEach { key in
            key.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        }
        NSLayoutConstraint.activate([
            keyDelete.widthAnchor.constraint(equalToConstant: SNKButtonSize.small),
            keyDelete.heightAnchor.constraint(equalToConstant: SNKButtonSize.small),
            keyDelete.centerXAnchor.constraint(equalTo: key9.centerXAnchor, constant: -2),
            keyDelete.centerYAnchor.constraint(equalTo: key0.centerYAnchor)
        ])
    }
    
}
