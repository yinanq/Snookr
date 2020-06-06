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
    var buttonsTopConstraint: NSLayoutConstraint!
    let effectView = UIVisualEffectView()
    let containerView = UIView()
    
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
        overrideUserInterfaceStyle = .dark
        configure()
        addButtonTargets()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animatedIn()
    }
    
    private func addButtonTargets() {
        cancelButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
    }
    
    @objc func didTapCancelButton() { animateOut() }
    
    @objc func didTapConfirmButton() { animateOut() }
    
    private func animatedIn() {
        UIView.animate(withDuration: SNKAnimationDuration.short, delay: 0, options: .curveEaseInOut, animations: {
            self.effectView.effect = UIBlurEffect(style: .systemChromeMaterial)
        }) { _ in
            UIView.animate(withDuration: SNKAnimationDuration.short) {
                self.containerView.alpha = 1
            }
        }
    }
    
    private func animateOut() {
        UIView.animate(withDuration: SNKAnimationDuration.short, delay: 0, options: .curveEaseInOut, animations: {
            self.containerView.alpha = 0
        }) { _ in
            UIView.animate(withDuration: SNKAnimationDuration.short, delay: 0, options: .curveEaseInOut, animations: {
                self.effectView.effect = nil
            }) { _ in
                self.dismiss(animated: true)
            }
        }
    }
    
    private func configure() {
        effectView.frame = view.bounds
        effectView.effect = nil
        containerView.alpha = 0
        [cancelButton, confirmButton].forEach { button in
            buttonsView.addSubview(button!)
            button?.widthAnchor.constraint(equalTo: buttonsView.widthAnchor, multiplier: 0.5, constant: -SNKPadding.big/2).isActive = true
        }
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubviews(titleLabel, bodyLabel, buttonsView)
        view.addSubviews(effectView, containerView)
        buttonsTopConstraint = buttonsView.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 45)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bodyLabel.topAnchor, constant: -SNKPadding.big),
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            bodyLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            bodyLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -15),
            bodyLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: SNKBodyWidth.percent),
//            buttonsView.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 45),
            buttonsTopConstraint,
            buttonsView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            buttonsView.widthAnchor.constraint(equalTo: bodyLabel.widthAnchor, constant: -8),
            cancelButton.topAnchor.constraint(equalTo: buttonsView.topAnchor),
            confirmButton.topAnchor.constraint(equalTo: buttonsView.topAnchor),
            cancelButton.leadingAnchor.constraint(equalTo: buttonsView.leadingAnchor),
            confirmButton.trailingAnchor.constraint(equalTo: buttonsView.trailingAnchor),
            buttonsView.bottomAnchor.constraint(equalTo: cancelButton.bottomAnchor)
        ])
    }

}
