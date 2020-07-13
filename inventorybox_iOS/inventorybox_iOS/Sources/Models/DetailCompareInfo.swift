//
//  DetailCompareInfo.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/12.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation

struct DetailCompareGraphInfo{
    
    var yearTextField: String?
    var monthTextField:String?
    var weekTextField:String?
    var secondYearTextField:String?
    var secondMonthTextField:String?
    var secondWeekTextField:String?
    var itemAlarmCount:Double?
    var dataPoints:[String]?
    var values1:[Double]?
  //  var values2:[Double]?
   
    
    
    init(yearTextField: String, monthTextField:String, weekTextField: String, secondYearTextField:String, secondMonthTextField:String, itemAlarmCount:Double, secondWeekTextField:String, dataPoints: [String], values1: [Double]){
        self.yearTextField = yearTextField
        self.monthTextField = monthTextField
        self.weekTextField = weekTextField
        self.secondYearTextField = secondYearTextField
        self.secondMonthTextField = secondMonthTextField
        self.secondWeekTextField = secondWeekTextField
        self.itemAlarmCount = itemAlarmCount
        self.dataPoints = dataPoints
        self.values1 = values1
      //  self.values2 = value2
    }
}
