//
//  SNKAlertVC.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/18/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

//protocol SNKAlertVCDelegate: class {
//    func didTapConfirmButtonForReset()
//}

import UIKit

class SNKAlertVC: UIViewController {
    
    var titleLabel: SNKLabel!
    var bodyLabel: SNKLabel!
    let buttonsView = UIView()
    var cancelButton: SNKButton!
    var confirmButton: SNKButton!
    
    init(title: String, body: String, cancelBtnTitle: String, confirmBtnTitile: String) {
        super.init(nibName: nil, bundle: nil)
        titleLabel = SNKLabel(fontSize: SNKFontSize.huge, fontWeight: SNKFontWeight.forFontSizeHuge)
        titleLabel.text = title
        bodyLabel = SNKLabel(fontSize: SNKFontSize.regular, fontWeight: SNKFontWeight.forFontSizeRegular, numberOfLines: 0)
        bodyLabel.text = body
        cancelButton = SNKButton(title: cancelBtnTitle, style: .solid)
        confirmButton = SNKButton(title: confirmBtnTitile, style: .solid)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addButtonTargets()
    }
    
    private func addButtonTargets() {
        cancelButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
    }
    
    @objc func didTapCancelButton() { dismiss(animated: true) }
    
    @objc func didTapConfirmButton() { dismiss(animated: true) }
    
    private func configure() {
        view.backgroundColor = SNKColor.background.withAlphaComponent(SNKAlpha.dimmer.rawValue)
        [cancelButton, confirmButton].forEach { button in
            buttonsView.addSubview(button!)
            button?.widthAnchor.constraint(equalTo: buttonsView.widthAnchor, multiplier: 0.5, constant: -SNKPadding.big/2).isActive = true
        }
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        [titleLabel, bodyLabel, buttonsView].forEach { subview in
            view.addSubview(subview!)
            subview?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        }
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: bodyLabel.topAnchor, constant: -SNKPadding.big),
            bodyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -15),
            bodyLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: SNKBodyWidth.percent),
            buttonsView.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 45),
            buttonsView.widthAnchor.constraint(equalTo: bodyLabel.widthAnchor, constant: -8),
            cancelButton.topAnchor.constraint(equalTo: buttonsView.topAnchor),
            confirmButton.topAnchor.constraint(equalTo: buttonsView.topAnchor),
            cancelButton.leadingAnchor.constraint(equalTo: buttonsView.leadingAnchor),
            confirmButton.trailingAnchor.constraint(equalTo: buttonsView.trailingAnchor),
            buttonsView.bottomAnchor.constraint(equalTo: cancelButton.bottomAnchor)
        ])
    }

}
