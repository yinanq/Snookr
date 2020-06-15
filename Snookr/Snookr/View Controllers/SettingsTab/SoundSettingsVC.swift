//
//  SoundSettingsVC.swift
//  Snookr
//
//  Created by Yinan Qiu on 6/10/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit
import AVFoundation

class SoundSettingsVC: UIViewController {
    
    var soundOff: Bool!
    var selectedCellRow: Int!
    let defaults = UserDefaults.standard
    let notifCtr = NotificationCenter.default
    
    let tableView = UITableView()
    let cellTitles = ["Always On", "Follow iPhone", "Always Off"]
    let cellBodies = ["Even if iPhone is in silent mode.", "On when iPhone is in ring mode. Off when iPhone is in silent mode.", "Never play sound effects."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
        configureChildren()
        configureToSaved()
    }
    
    private func configureSelf() {
        overrideUserInterfaceStyle = .dark
        view.backgroundColor = SNKColor.background
        title = "Sound"
        navigationController?.navigationBar.tintColor = SNKColor.foreground
    }
    
    private func configureChildren() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SNKSoundSettingsCell.self, forCellReuseIdentifier: SNKSoundSettingsCell.reuseID)
        tableView.frame = view.bounds
        tableView.separatorStyle = .none
        view.addSubview(tableView)
    }
    
    private func configureToSaved() {
        soundOff = defaults.bool(forKey: SNKCommonKey.soundOff)
        if soundOff {
            selectedCellRow = 2
        } else if defaults.bool(forKey: SNKCommonKey.soundAlwaysOn) {
            selectedCellRow = 0
        } else {
            selectedCellRow = 1
        }
    }
    
    private func setSoundOff(to bool: Bool) {
        soundOff = bool
        defaults.setValue(soundOff, forKey: SNKCommonKey.soundOff)
        switch bool {
        case true: notifCtr.post(name: .turnSoundOff, object: nil)
        case false: notifCtr.post(name: .turnSoundOn, object: nil)
        }
    }
    
    private func setSoundAlwaysOn(to bool: Bool) {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(false, options: .notifyOthersOnDeactivation)
            switch bool {
            case true: try audioSession.setCategory(.playback, options: .mixWithOthers)
            case false: try audioSession.setCategory(.ambient)
            }
            try audioSession.setActive(true)
        } catch {
            print("error: Failed to set audio session category, in SoundSettingsVC.")
        }
        defaults.setValue(bool, forKey: SNKCommonKey.soundAlwaysOn)
    }
}

extension SoundSettingsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { cellTitles.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SNKSoundSettingsCell.reuseID) as! SNKSoundSettingsCell
        cell.setTitleText(to: cellTitles[indexPath.row])
        cell.setBodyText(to: cellBodies[indexPath.row])
        if indexPath[1] == selectedCellRow {
            cell.setToSelectedSkipAnimation()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell0 = tableView.cellForRow(at: [0,0]) as! SNKSoundSettingsCell
        let cell1 = tableView.cellForRow(at: [0,1]) as! SNKSoundSettingsCell
        let cell2 = tableView.cellForRow(at: [0,2]) as! SNKSoundSettingsCell
        let row = indexPath[1]
        switch row {
        case 0:
            cell0.setToSelected()
            cell1.setToUnselected()
            cell2.setToUnselected()
            setSoundAlwaysOn(to: true)
            setSoundOff(to: false)
        case 1:
            cell0.setToUnselected()
            cell1.setToSelected()
            cell2.setToUnselected()
            setSoundAlwaysOn(to: false)
            setSoundOff(to: false)
        case 2:
            cell0.setToUnselected()
            cell1.setToUnselected()
            cell2.setToSelected()
            setSoundOff(to: true)
        default: print("error: invalid row in SoundSettingsVC (Shouldn't use table view here anyway)")
        }
    }
    
}
