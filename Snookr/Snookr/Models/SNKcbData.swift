//
//  SNKcbData.swift
//  Snookr
//
//  Created by Yinan Qiu on 5/25/20.
//  Copyright © 2020 Yinan. All rights reserved.
//

import Foundation

struct SNKcbData: Codable {
    
    var snkCBDataType: String
    
    var playerName: String?
    
    var frame: Int?
    
    var score: Int?
    var scoreHist1: Int?
    var scoreHist2: Int?
    var scoreHist3: Int?
    
    init(snkCBDataType: String, playerName: String? = nil, frame: Int? = nil, score: Int? = nil, scoreHist1: Int? = nil, scoreHist2: Int? = nil, scoreHist3: Int? = nil) {
        self.snkCBDataType = snkCBDataType
        self.playerName = playerName
        self.frame = frame
        self.score = score
        self.scoreHist1 = scoreHist1
        self.scoreHist2 = scoreHist2
        self.scoreHist3 = scoreHist3
    }
    
}
