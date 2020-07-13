//
//  InventoryEditProductInformation.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/12.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation

struct InventoryEditProductInformation {
    var inventoryImageName: String
    var inventoryName: String
    var category: String
    var inventoryCount: String
    var isTextFieldTyped: Bool
    
    init(imageName: String, ivName: String, category: String, count: String) {
        self.inventoryImageName = imageName
        self.inventoryName = ivName
        self.category = category
        self.inventoryCount = count
        self.isTextFieldTyped = false
    }
}
