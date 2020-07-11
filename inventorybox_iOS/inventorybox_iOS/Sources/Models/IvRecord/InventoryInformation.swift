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
    
}
