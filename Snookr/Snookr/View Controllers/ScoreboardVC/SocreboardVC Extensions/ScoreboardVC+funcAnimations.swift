//
//  ScoreboardVC+funcAnimations.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/16/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

//func animations:
extension ScoreboardVC {
    
    func playFrameStarterAnimation() {
        view.alpha = 0
        UIView.animate(withDuration: SNKAnimationDuration.long, delay: 0, options: .curveEaseIn, animations: { self.view.alpha = 1 })
    }
    
    func playLaunchScreenSmootherAnimation() {
        let logoImageView = UIImageView(image: UIImage(named: "logo-green"))
        let backgroundView = UIView()
        backgroundView.addSubview(logoImageView)
        view.addSubview(backgroundView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        backgroundView.backgroundColor = SNKColor.background
        UIView.animate(withDuration: SNKAnimationDuration.short, delay: 1.47, options: .curveEaseInOut, animations: {
            logoImageView.alpha = 0
        }) { _ in
            backgroundView.removeFromSuperview()
            self.playFrameStarterAnimation()
        }
    }
    
}
