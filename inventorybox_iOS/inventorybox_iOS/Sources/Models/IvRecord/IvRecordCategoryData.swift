//
//  IvRecordCategoryData.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/16.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation

// MARK: - IvRecordCategoryData
struct IvRecordCategoryData: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: CategoryClass
}

// MARK: - DataClass
struct CategoryClass: Codable {
    let categoryInfo: [CategoryInfo]
}

