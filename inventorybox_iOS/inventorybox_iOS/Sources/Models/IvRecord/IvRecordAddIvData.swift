//
//  IvRecordAddIvData.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/14.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation

// ⭐️
// MARK: - IvRecordAddIvData
struct IvRecordAddIvData: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: AddIvClass
}

// ⭐️⭐️
// MARK: - DataClass
struct AddIvClass: Codable {
    let iconInfo: [IconInfo]
    let categoryInfo: [CategoryInfo]
}

// ⭐️⭐️⭐️
// MARK: - IconInfo
struct IconInfo: Codable {
    let iconIdx: Int
    let img: String
    let name: String
}

