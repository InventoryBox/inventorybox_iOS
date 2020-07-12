//
//  CategoryData.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/08.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation

struct CategoryInformation {
    var categoryIdx: Int?
    var categoryName: String = ""
    
    init(idx: Int, name: String) {
        self.categoryIdx = idx
        self.categoryName = name
    }
    
}

