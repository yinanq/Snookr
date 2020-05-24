//
//  MCData.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/23/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import Foundation

struct MCData: Codable {
    
    var type: Int
    
    var name: String?
    
    var frame: Int?
    
    var score: Int?
    var scoreHist1: Int?
    var scoreHist2: Int?
    var scoreHIst3: Int?
    
    init(snkDataTypeForMC: Int, name: String? = nil, frame: Int? = nil, score: Int? = nil, scoreHist1: Int? = nil, scoreHist2: Int? = nil, scoreHist3: Int? = nil) {
        self.type = snkDataTypeForMC
        self.name = name
        self.frame = frame
        self.score = score
        self.scoreHist1 = scoreHist1
        self.scoreHist2 = scoreHist2
        self.scoreHIst3 = scoreHist3
    }
    
}
