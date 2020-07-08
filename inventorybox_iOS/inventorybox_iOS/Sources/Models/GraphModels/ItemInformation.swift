//
//  ItemInformation.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/07.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation

struct ItemInformation{
    var itemImg: String?
    var itemName:String?
    var itemAlarmCount:Double?
    var dataPoints:[String]?
    var values:[Double]?
    
    
    init(itemImg: String, itemName:String, itemAlarmCount:Double, dataPoints: [String], values: [Double]){
        self.itemImg = itemImg
        self.itemName = itemName
        self.itemAlarmCount = itemAlarmCount
        self.dataPoints = dataPoints
        self.values = values
    }
}
