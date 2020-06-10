//
//  SettingsVC.swift
//  Snookr
//
//  Created by Yinan Qiu on 6/9/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    let tableView = UITableView()
    let cellTitles = ["Sound", "About"]

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
        configureChildren()
    }
    
    private func configureSelf() {
        overrideUserInterfaceStyle = .dark
        title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        let attributes = [NSAttributedString.Key.foregroundColor : SNKColor.foreground]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationController?.navigationBar.layoutMargins.left = SNKPadding.big
    }
    
    private func configureChildren() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SNKSettingsCell.self, forCellReuseIdentifier: SNKSettingsCell.reuseID)
        tableView.frame = view.bounds
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
        view.addSubview(tableView)
    }

}

extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SNKSettingsCell.reuseID) as! SNKSettingsCell
        cell.setTitleText(to: cellTitles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0: print("tapped Sound setting cell")
        case 1: navigationController?.pushViewController(InfoVC(), animated: true)
        default: print("error: invalid indexPath in tableView didSelectRowAt")
        }
    }
}
