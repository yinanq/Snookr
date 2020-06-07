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
    let effectView = UIVisualEffectView()
    let containerView = UIView()
    var buttonsViewTopC: NSLayoutConstraint!
    
    init(title: String, body: String, cancelBtnTitle: String, confirmBtnTitile: String) {
        super.init(nibName: nil, bundle: nil)
        titleLabel = SNKLabel(color: SNKColor.foregroundWhite, fontSize: SNKFontSize.huge, fontWeight: SNKFontWeight.forFontSizeHuge, textAlignment: .left)
        titleLabel.text = title
        bodyLabel = SNKLabel(color: SNKColor.foregroundWhite, fontSize: SNKFontSize.regular, fontWeight: SNKFontWeight.forFontSizeRegular, textAlignment: .left, numberOfLines: 0)
        bodyLabel.text = body
        cancelButton = SNKButton(title: cancelBtnTitle, style: .solid)
        confirmButton = SNKButton(title: confirmBtnTitile, style: .solid)
        cancelButton.backgroundColor = SNKColor.foregroundWhite
        confirmButton.backgroundColor = SNKColor.foregroundWhite
        cancelButton.setTitleColor(SNKColor.foreground, for: .highlighted)
        confirmButton.setTitleColor(SNKColor.foreground, for: .highlighted)
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
        UIView.animate(withDuration: SNKAnimationDuration.short, delay: 0, options: .curveEaseOut, animations: {
            self.effectView.effect = UIBlurEffect(style: .systemChromeMaterial)
        }) { _ in
            UIView.animate(withDuration: SNKAnimationDuration.short) {
                self.containerView.alpha = 1
            }
        }
    }
    
    private func animateOut() {
        UIView.animate(withDuration: SNKAnimationDuration.short, delay: 0, options: .curveEaseOut, animations: {
            self.containerView.alpha = 0
        }) { _ in
            UIView.animate(withDuration: SNKAnimationDuration.short, delay: 0, options: .curveEaseOut, animations: {
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
        [titleLabel, bodyLabel, buttonsView].forEach { view in
            containerView.addSubview(view!)
            view?.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
            view?.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        }
        view.addSubviews(effectView, containerView)
        buttonsViewTopC = buttonsView.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 45)
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: SNKBodyWidth.percent),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: SNKPadding.big),
            buttonsViewTopC,
            buttonsView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            buttonsView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            cancelButton.topAnchor.constraint(equalTo: buttonsView.topAnchor),
            confirmButton.topAnchor.constraint(equalTo: buttonsView.topAnchor),
            cancelButton.leadingAnchor.constraint(equalTo: buttonsView.leadingAnchor),
            confirmButton.trailingAnchor.constraint(equalTo: buttonsView.trailingAnchor),
            buttonsView.bottomAnchor.constraint(equalTo: cancelButton.bottomAnchor),
            containerView.bottomAnchor.constraint(equalTo: buttonsView.bottomAnchor)
        ])
    }
    
}
