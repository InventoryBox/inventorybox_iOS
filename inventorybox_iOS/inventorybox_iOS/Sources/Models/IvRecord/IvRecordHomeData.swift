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
    let data: IvRecordHomeClass?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case success = "success"
        case message = "message"
        case data = "data"
    }
    
    //값이 없을 경우 nil값 집어넣기?
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = (try? values.decode(Int.self, forKey: .status)) ?? -1
        success = (try? values.decode(Bool.self, forKey: .success)) ?? false
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode(IvRecordHomeClass.self, forKey: .data)) ?? nil
    }
}

// ⭐️⭐️
// MARK: - IvRecordHomeClass
struct IvRecordHomeClass: Codable {
    let itemInfo: [HomeItemInfo]?
    let categoryInfo: [CategoryInfo] 
    let isRecorded: Int
    let date: String?
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
    let stocksCnt: Int
    let categoryIdx: Int
    let img: String
}
