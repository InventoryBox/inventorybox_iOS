//
//  File.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/05.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation

struct InventoryInformation {
    var inventoryImageName: String
    var inventoryName: String
    var minimumInventory: String
    var inventoryUnit: String
    var inventoryCount: String
    var category: String
    
    init(imageName: String, ivName: String, mInventory: String, unit: String, iCount: String, categoryNum: String) {
        self.inventoryImageName = imageName
        self.inventoryName = ivName
        self.minimumInventory = mInventory
        self.inventoryUnit = unit
        self.inventoryCount = iCount
        self.category = categoryNum
    }
    
    static var inventoryArray: [InventoryInformation] = {
        
        let data1 = InventoryInformation(imageName: "homeIcMilk", ivName: "우유", mInventory: "5", unit: "팩", iCount: "99", categoryNum: "액체류")
        let data2 = InventoryInformation(imageName: "homeIcMilk", ivName: "녹차 파우더", mInventory: "10", unit: "팩", iCount: "3", categoryNum: "액체류")
        let data3 = InventoryInformation(imageName: "homeIcStrawberry", ivName: "딸기",  mInventory: "10", unit: "팩",  iCount: "3", categoryNum: "과일")
        let data4 = InventoryInformation(imageName: "homeIcMcpowder", ivName: "모카 파우더",  mInventory: "10", unit: "통", iCount: "3", categoryNum: "파우더류")
        let data5 = InventoryInformation(imageName: "homeIcStrawberry", ivName: "사과",  mInventory: "10", unit: "개", iCount: "3", categoryNum: "과일")
        let data6 = InventoryInformation(imageName: "homeIcStrawberry", ivName: "수박",  mInventory: "10", unit: "개", iCount: "3", categoryNum: "과일")
        let data7 = InventoryInformation(imageName: "homeIcMilk", ivName: "우유",  mInventory: "10", unit: "팩", iCount: "99", categoryNum: "액체류")
        let data8 = InventoryInformation(imageName: "homeIcMilk", ivName: "녹차 파우더",  mInventory: "10", unit: "팩", iCount: "3", categoryNum: "파우더류")
        let data9 = InventoryInformation(imageName: "homeIcStrawberry", ivName: "딸기",  mInventory: "10", unit: "팩", iCount: "3", categoryNum: "과일")
        let data10 = InventoryInformation(imageName: "homeIcMcpowder", ivName: "모카 파우더",  mInventory: "10", unit: "팩", iCount: "3", categoryNum: "액체류")
        let data11 = InventoryInformation(imageName: "homeIcStrawberry", ivName: "사과",  mInventory: "10", unit: "개", iCount: "3", categoryNum: "과일")
        let data12 = InventoryInformation(imageName: "homeIcStrawberry", ivName: "수박",  mInventory: "10", unit: "개", iCount: "3", categoryNum: "과일")
        
        return [data1, data2, data3, data4, data5, data6, data7, data8, data9, data10, data11, data12]
        
    }()
}
