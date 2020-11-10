//
//  WeekInformation.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/09.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation

struct WeekInformation{
    var weekInfo:Int
    var btnText: String
    var btnIsSelected:Bool
    
    init(weekInfo:Int,btnText: String, btnIsSelected:Bool){
        self.weekInfo = weekInfo
        self.btnText = btnText
        self.btnIsSelected = btnIsSelected
       
    }
}
