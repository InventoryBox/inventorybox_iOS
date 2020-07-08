//
//  File.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/05.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation

struct InventoryData {
    var inventoryImageName: String
    var inventoryName: String
    var minimumInventory: String
    var orderInventory: String
    var inventoryCount: String
    var category: String
    
    init(imageName: String, ivName: String, mInventory: String, oInventory: String, iCount: String, categoryNum: String) {
        self.inventoryImageName = imageName
        self.inventoryName = ivName
        self.minimumInventory = mInventory
        self.orderInventory = oInventory
        self.inventoryCount = iCount
        self.category = categoryNum
    }
    
    static var inventoryArray: [InventoryData] = {
        
        let data1 = InventoryData(imageName: "homeIcMilk", ivName: "우유", mInventory: "5팩", oInventory: "10팩", iCount: "3", categoryNum: "액체류")
        let data2 = InventoryData(imageName: "homeIcMilk", ivName: "녹차 파우더", mInventory: "10개", oInventory: "10팩", iCount: "3", categoryNum: "액체류")
        let data3 = InventoryData(imageName: "homeIcStrawberry", ivName: "딸기", mInventory: "10팩", oInventory: "10팩", iCount: "3", categoryNum: "과일")
        let data4 = InventoryData(imageName: "homeIcMcpowder", ivName: "모카 파우더", mInventory: "5팩", oInventory: "10팩", iCount: "3", categoryNum: "액체류")
        let data5 = InventoryData(imageName: "homeIcStrawberry", ivName: "사과", mInventory: "5팩", oInventory: "10팩", iCount: "3", categoryNum: "과일")
        let data6 = InventoryData(imageName: "homeIcStrawberry", ivName: "수박", mInventory: "5팩", oInventory: "10팩", iCount: "3", categoryNum: "과일")
        let data7 = InventoryData(imageName: "homeIcMilk", ivName: "우유", mInventory: "5팩", oInventory: "10팩", iCount: "3", categoryNum: "액체류")
        let data8 = InventoryData(imageName: "homeIcMilk", ivName: "녹차 파우더", mInventory: "10개", oInventory: "10팩", iCount: "3", categoryNum: "액체류")
        let data9 = InventoryData(imageName: "homeIcStrawberry", ivName: "딸기", mInventory: "10팩", oInventory: "10팩", iCount: "3", categoryNum: "과일")
        let data10 = InventoryData(imageName: "homeIcMcpowder", ivName: "모카 파우더", mInventory: "5팩", oInventory: "10팩", iCount: "3", categoryNum: "액체류")
        let data11 = InventoryData(imageName: "homeIcStrawberry", ivName: "사과", mInventory: "5팩", oInventory: "10팩", iCount: "3", categoryNum: "과일")
        let data12 = InventoryData(imageName: "homeIcStrawberry", ivName: "수박", mInventory: "5팩", oInventory: "10팩", iCount: "3", categoryNum: "과일")
        
        return [data1, data2, data3, data4, data5, data6, data7, data8, data9, data10, data11, data12]
        
    }()
}
