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
    var itemIndex:Int?
    
    
    init(weekLabel: String, firstMonth:String, firstDay: String, secondMonth:String, secondDay:String,itemAlarmCount:Double, dataPoints: [String], values: [Double], itemIndex:Int){
        self.weekLabel = weekLabel
        self.firstMonth = firstMonth
        self.firstDay = firstDay
        self.secondMonth = secondMonth
        self.secondDay = secondDay
        self.itemAlarmCount = itemAlarmCount
        self.dataPoints = dataPoints
        self.values = values
        self.itemIndex = itemIndex
    }
    
    
//    static var inventoryGraphArray: [DetailGraphWeekInfo] = {
//
//        let data1 = InventoryEditInformation(imageName: "homeIcMilk", ivName: "우유", mInventory: "5", unit: "팩", categoryNum: "액체류")
//        let data2 = InventoryEditInformation(imageName: "homeIcMilk", ivName: "녹차 파우더", mInventory: "10", unit: "팩",  categoryNum: "액체류")
//        let data3 = InventoryEditInformation(imageName: "homeIcStrawberry", ivName: "딸기",  mInventory: "10", unit: "팩",   categoryNum: "과일")
//        let data4 = InventoryEditInformation(imageName: "homeIcMcpowder", ivName: "모카 파우더",  mInventory: "10", unit: "통",  categoryNum: "파우더류")
//        let data5 = InventoryEditInformation(imageName: "homeIcStrawberry", ivName: "사과",  mInventory: "10", unit: "개",  categoryNum: "과일")
//        let data6 = InventoryEditInformation(imageName: "homeIcStrawberry", ivName: "수박",  mInventory: "10", unit: "개",  categoryNum: "과일")
//        let data7 = InventoryEditInformation(imageName: "homeIcMilk", ivName: "우유",  mInventory: "10", unit: "팩",  categoryNum: "액체류")
//        let data8 = InventoryEditInformation(imageName: "homeIcMilk", ivName: "녹차 파우더",  mInventory: "10", unit: "팩",  categoryNum: "파우더류")
//        let data9 = InventoryEditInformation(imageName: "homeIcStrawberry", ivName: "딸기",  mInventory: "10", unit: "팩",  categoryNum: "과일")
//        let data10 = InventoryEditInformation(imageName: "homeIcMcpowder", ivName: "모카 파우더",  mInventory: "10", unit: "팩",  categoryNum: "액체류")
//        let data11 = InventoryEditInformation(imageName: "homeIcStrawberry", ivName: "사과",  mInventory: "10", unit: "개",  categoryNum: "과일")
//        let data12 = InventoryEditInformation(imageName: "homeIcStrawberry", ivName: "수박",  mInventory: "10", unit: "개",  categoryNum: "과일")
//
//        return [data1, data2, data3, data4, data5, data6, data7, data8, data9, data10, data11, data12]
//
//    }()
//
}
