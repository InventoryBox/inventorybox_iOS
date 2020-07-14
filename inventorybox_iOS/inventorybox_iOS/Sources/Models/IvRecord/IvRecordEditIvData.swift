//
//  IvRecordEditIvData.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/14.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation

// MARK: - IvRecordEditIvData
struct IvRecordEditIvData: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: IvRecordEditIvClass
}

// MARK: - IvRecordEditIvClass
struct IvRecordEditIvClass: Codable {
    let itemInfo: [EditItemInfo]
    let categoryInfo: [CategoryInfo]
}

// MARK: - EditItemInfo
struct EditItemInfo: Codable {
    let itemIdx: Int
    let name: String
    let categoryIdx, stocksCnt: Int
    let img: String
}
