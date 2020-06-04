//
//  SnookersBallsVC+UIPickerViewDataSource.swift
//  Snookr
//
//  Created by Yinan Qiu on 6/3/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import UIKit

extension SnookersBallsVC: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ballsPickerOptionStrings.count
    }
    
}
