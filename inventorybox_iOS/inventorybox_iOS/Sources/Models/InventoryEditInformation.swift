//
//  InventoryEditInformation.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/09.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation

struct InventoryEditInformation {
    var inventoryImageName: String
    var inventoryName: String
    var minimumInventory: String
    var inventoryUnit: String
    var category: String
    var isSelected: Bool = false
    
    init(imageName: String, ivName: String, mInventory: String, unit: String, categoryNum: String) {
        self.inventoryImageName = imageName
        self.inventoryName = ivName
        self.minimumInventory = mInventory
        self.inventoryUnit = unit
        self.category = categoryNum
    }
    
    static var inventoryEditArray: [InventoryEditInformation] = {
        
        let data1 = InventoryEditInformation(imageName: "homeIcMilk", ivName: "우유", mInventory: "5", unit: "팩", categoryNum: "액체류")
        let data2 = InventoryEditInformation(imageName: "homeIcMilk", ivName: "녹차 파우더", mInventory: "10", unit: "팩",  categoryNum: "액체류")
        let data3 = InventoryEditInformation(imageName: "homeIcStrawberry", ivName: "딸기",  mInventory: "10", unit: "팩",   categoryNum: "과일")
        let data4 = InventoryEditInformation(imageName: "homeIcMcpowder", ivName: "모카 파우더",  mInventory: "10", unit: "통",  categoryNum: "파우더류")
        let data5 = InventoryEditInformation(imageName: "homeIcStrawberry", ivName: "사과",  mInventory: "10", unit: "개",  categoryNum: "과일")
        let data6 = InventoryEditInformation(imageName: "homeIcStrawberry", ivName: "수박",  mInventory: "10", unit: "개",  categoryNum: "과일")
        let data7 = InventoryEditInformation(imageName: "homeIcMilk", ivName: "우유",  mInventory: "10", unit: "팩",  categoryNum: "액체류")
        let data8 = InventoryEditInformation(imageName: "homeIcMilk", ivName: "녹차 파우더",  mInventory: "10", unit: "팩",  categoryNum: "파우더류")
        let data9 = InventoryEditInformation(imageName: "homeIcStrawberry", ivName: "딸기",  mInventory: "10", unit: "팩",  categoryNum: "과일")
        let data10 = InventoryEditInformation(imageName: "homeIcMcpowder", ivName: "모카 파우더",  mInventory: "10", unit: "팩",  categoryNum: "액체류")
        let data11 = InventoryEditInformation(imageName: "homeIcStrawberry", ivName: "사과",  mInventory: "10", unit: "개",  categoryNum: "과일")
        let data12 = InventoryEditInformation(imageName: "homeIcStrawberry", ivName: "수박",  mInventory: "10", unit: "개",  categoryNum: "과일")
        
        return [data1, data2, data3, data4, data5, data6, data7, data8, data9, data10, data11, data12]
        
    }()
}
