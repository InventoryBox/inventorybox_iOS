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
        let data2 = InventoryData(imageName: "homeIcMilk", ivName: "우유", mInventory: "5팩", oInventory: "10팩", iCount: "3", categoryNum: "액체류")
        let data3 = InventoryData(imageName: "homeIcMilk", ivName: "우유", mInventory: "5팩", oInventory: "10팩", iCount: "3", categoryNum: "액체류")
        let data4 = InventoryData(imageName: "homeIcMilk", ivName: "우유", mInventory: "5팩", oInventory: "10팩", iCount: "3", categoryNum: "액체류")
        let data5 = InventoryData(imageName: "homeIcMilk", ivName: "우유", mInventory: "5팩", oInventory: "10팩", iCount: "3", categoryNum: "액체류")
        let data6 = InventoryData(imageName: "homeIcMilk", ivName: "우유", mInventory: "5팩", oInventory: "10팩", iCount: "3", categoryNum: "액체류")
        
        return [data1, data2, data3, data4, data5]
        
    }()
}
