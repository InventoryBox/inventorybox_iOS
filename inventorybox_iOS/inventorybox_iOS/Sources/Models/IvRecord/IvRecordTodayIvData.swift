//
//  IvRecordTodayIvData.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/14.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation

// ⭐️
// MARK: - IvRecordTodayIvData
struct IvRecordTodayIvData: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: IvRecordTodayIvClass
}

// ⭐️⭐️
// MARK: - IvRecordTodayIvClass
struct IvRecordTodayIvClass: Codable {
    let itemInfo: [TodayItemInfo]
    let categoryInfo: [CategoryInfo]
    let date: String
}


// ⭐️⭐️⭐️
// MARK: - TodayItemInfo
// 재고 조회 모델
// 재고 조회, 오늘 재고 기록, 재고 수정 모두 다 다른 데이터로 할까?
struct TodayItemInfo: Codable {
    let itemIdx: Int
    let name: String
    let categoryIdx: Int
}
