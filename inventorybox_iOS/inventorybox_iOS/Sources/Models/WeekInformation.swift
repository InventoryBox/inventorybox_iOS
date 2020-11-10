//
//  WeekInformation.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/09.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation

struct WeekInformation{
    var btnText: String
    var btnIsSelected:Bool
    
    init(btnText: String, btnIsSelected:Bool){
        self.btnText = btnText
        self.btnIsSelected = btnIsSelected
       
    }
}
