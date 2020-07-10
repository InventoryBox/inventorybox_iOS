//
//  InventoryTodayInformation.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/11.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation

struct InventoryTodayInformation {
    var inventoryImageName: String
    var inventoryName: String
    var category: String
    var inventoryCount: String?
    var isTextFieldTyped: Bool
    
    init(imageName: String, ivName: String, categoryNum: String, isTyped: Bool) {
        self.inventoryImageName = imageName
        self.inventoryName = ivName
        self.category = categoryNum
        self.isTextFieldTyped = isTyped
    }
}
