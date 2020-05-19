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
        tabBar.barStyle = .black
        tabBar.tintColor = SNKColor.foreground
        viewControllers = [framesTabVC(), scoreboardTabVC(), infoTabVC()]
        selectedIndex = 1
        playLaunchScreenSmootherAnimation()
    }
    
    private func framesTabVC() -> UIViewController {
        let framesVC = FramesVC()
        framesVC.tabBarItem = UITabBarItem(title: "Frames", image: nil, tag: 11)
        return framesVC
    }
    
    private func scoreboardTabVC() -> UIViewController {
        let scoreboardVC = ScoreboardVC()
        scoreboardVC.tabBarItem = UITabBarItem(title: "Scores", image: nil, tag: 12)
        return scoreboardVC
    }
    
    private func infoTabVC() -> UIViewController {
        let infoVC = InfoVC()
        infoVC.tabBarItem = UITabBarItem(title: "About", image: nil, tag: -1)
        return infoVC
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
