//
//  TabBarVC.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/18/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
        configureTabs()
        playLaunchScreenSmootherAnimation()
    }
    
    private func configureTabBar() {
        tabBar.barStyle = .black
        tabBar.tintColor = SNKColor.foreground
    }
    
    private func configureTabs() {
        let framesVC = FramesVC()
        let scoreboardVC = ScoreboardVC()
        let infoVC = InfoVC()
        framesVC.delegate = scoreboardVC
        scoreboardVC.delegate = framesVC
        framesVC.tabBarItem = UITabBarItem(title: "Frames", image: UIImage(systemName: "square.grid.3x2.fill"), tag: 11)
        scoreboardVC.tabBarItem = UITabBarItem(title: "Scores", image: UIImage(systemName: "square.split.2x1.fill"), tag: 12)
        infoVC.tabBarItem = UITabBarItem(title: "About", image: UIImage(systemName: "info.circle.fill"), tag: 21)
        viewControllers = [framesVC, scoreboardVC, infoVC]
        selectedIndex = 1
    }
    
    private func playLaunchScreenSmootherAnimation() {
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
        UIView.animate(withDuration: SNKAnimationDuration.launchSmootherDuration, delay: SNKAnimationDuration.launchSmootherDelay, options: .curveEaseInOut, animations: {
            logoImageView.alpha = 0
        }) { _ in
            backgroundView.removeFromSuperview()
            self.tabBar.alpha = 0
            UIView.animate(withDuration: SNKAnimationDuration.long, delay: 0, options: .curveEaseIn, animations: { self.tabBar.alpha = 1 })
        }
    }

}
