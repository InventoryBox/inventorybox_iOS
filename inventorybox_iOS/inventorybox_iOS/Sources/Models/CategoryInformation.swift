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
    
    static var categories: [String] = {
        let data1 = CategoryInformation(idx: 1, name: "전체")
        let data2 = CategoryInformation(idx: 2, name: "액체류")
        let data3 = CategoryInformation(idx: 3, name: "파우더류")
        let data4 = CategoryInformation(idx: 4, name: "과일")
        let data5 = CategoryInformation(idx: 5, name: "채소류")
        let data6 = CategoryInformation(idx: 6, name: "스파게티 재료들")
        let data7 = CategoryInformation(idx: 7, name: "아침마다 확인해야 할 것들")
        
        return [data1.categoryName, data2.categoryName, data3.categoryName, data4.categoryName, data5.categoryName, data6.categoryName, data7.categoryName]
    }()
    
}

