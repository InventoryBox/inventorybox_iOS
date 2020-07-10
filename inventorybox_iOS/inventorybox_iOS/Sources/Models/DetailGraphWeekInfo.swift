//
//  DetailGraphWeekInfo.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/09.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation

struct DetailGraphWeekInfo{
    
    var weekLabel: String?
    var firstMonth:String?
    var firstDay:String?
    var secondMonth:String?
    var secondDay:String?
    var itemAlarmCount:Double?
    var dataPoints:[String]?
    var values:[Double]?
    
    
    init(weekLabel: String, firstMonth:String, firstDay: String, secondMonth:String, secondDay:String,itemAlarmCount:Double, dataPoints: [String], values: [Double]){
        self.weekLabel = weekLabel
        self.firstMonth = firstMonth
        self.firstDay = firstDay
        self.secondMonth = secondMonth
        self.secondDay = secondDay
        self.itemAlarmCount = itemAlarmCount
        self.dataPoints = dataPoints
        self.values = values
    }
}
