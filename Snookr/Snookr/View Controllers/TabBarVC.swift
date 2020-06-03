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
        let connectVC = ConnectVC()
        let scoreboardVC = ScoreboardVC()
        let framesVC = FramesVC()
        let snookersVC = SnookersVC()
        let infoVC = InfoVC()
        connectVC.tabBarItem = UITabBarItem(title: "Connect", image: SNKTabBarImage.connect, tag: 0)
        scoreboardVC.tabBarItem = UITabBarItem(title: "Scores", image: SNKTabBarImage.scores, tag: 12)
        framesVC.tabBarItem = UITabBarItem(title: "Frames", image: SNKTabBarImage.frames, tag: 11)
        snookersVC.tabBarItem = UITabBarItem(title: "Snookers", image: SNKTabBarImage.snookers, tag: 13)
        infoVC.tabBarItem = UITabBarItem(title: "About", image: SNKTabBarImage.about, tag: 21)
        viewControllers = [connectVC, scoreboardVC, framesVC, snookersVC, infoVC]
        selectedIndex = 0
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
