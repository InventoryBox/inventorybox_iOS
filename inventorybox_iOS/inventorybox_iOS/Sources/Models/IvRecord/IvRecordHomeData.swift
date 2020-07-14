//
//  InventoryRecordData.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/14.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation

// ⭐️
// MARK: - IvRecordHomeData
struct IvRecordHomeData: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: IvRecordHomeClass
}

// ⭐️⭐️
// MARK: - IvRecordHomeClass
struct IvRecordHomeClass: Codable {
    let itemInfo: [HomeItemInfo]
    let categoryInfo: [CategoryInfo] 
    let isRecorded: Int
    let date: String
    let picker, addButton: Int
}


// ⭐️⭐️⭐️
// MARK: - HomeItemInfo
// 재고 조회 모델
// 재고 조회, 오늘 재고 기록, 재고 수정 모두 다 다른 데이터로 할까?
struct HomeItemInfo: Codable {
    let itemIdx: Int
    let name: String
    let alarmCnt: Int
    let unit: String
    let stocksCnt, categoryIdx: Int
    let img: String
}
