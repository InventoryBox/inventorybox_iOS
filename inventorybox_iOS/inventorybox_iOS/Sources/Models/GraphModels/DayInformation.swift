//
//  DayInformation.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/06.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation

struct DayInformation{
    var currentDay: String?
    var currentWeekOfDay:String
    var isToday:Bool?

    init(currentDay: String, currentWeekOfDay:String, isToday:Bool){
        self.currentDay = currentDay
        self.currentWeekOfDay = currentWeekOfDay
        self.isToday = isToday
        print(isToday)
    }
}
