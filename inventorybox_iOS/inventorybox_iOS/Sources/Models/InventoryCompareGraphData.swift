//
//  InventoryCompareGraphData.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/16.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation

struct InventoryCompareGraphData: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: CompareWeekData?
}

// MARK: - DataClass
struct CompareWeekData: Codable {
    let week1, week2: [Int]
}
