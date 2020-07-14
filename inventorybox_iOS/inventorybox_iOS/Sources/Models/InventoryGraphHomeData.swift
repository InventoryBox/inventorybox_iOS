//
//  InventoryGraphHomeData.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/14.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct InventoryGraphHomeData: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: ThisWeekData?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case success = "success"
        case message = "message"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = (try? values.decode(Int.self, forKey: .status)) ?? -1
        success = (try? values.decode(Bool.self, forKey: .success)) ?? false
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode(ThisWeekData.self, forKey: .data)) ?? nil
    }
}

// MARK: - DataClass
struct ThisWeekData: Codable {
    let thisWeekDates: [String]
    let categoryInfo: [CategoryInfo]
    let itemInfo: [ItemInfo]
}

// MARK: - CategoryInfo
struct CategoryInfo: Codable {
    let categoryIdx: Int
    let name: String
}

// MARK: - ItemInfo
struct ItemInfo: Codable {
    let itemIdx: Int
    let name: String
    let categoryIdx, alarmCnt: Int
    let iconImg: String
    let stocks: [Int]
}
