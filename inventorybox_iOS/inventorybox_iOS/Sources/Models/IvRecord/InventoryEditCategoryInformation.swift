//
//  InventoryEditInformation.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/09.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation

struct InventoryEditCategoryInformation {
    var inventoryImageName: String
    var inventoryName: String
    var minimumInventory: String
    var inventoryUnit: String
    var category: String
    var isSelected: Bool
    
    init(imageName: String, ivName: String, mInventory: String, unit: String, categoryNum: String, select: Bool) {
        self.inventoryImageName = imageName
        self.inventoryName = ivName
        self.minimumInventory = mInventory
        self.inventoryUnit = unit
        self.category = categoryNum
        self.isSelected = select
    }
}
