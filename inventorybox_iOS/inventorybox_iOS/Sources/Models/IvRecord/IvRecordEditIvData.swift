//
//  IvRecordEditIvData.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/14.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation

// ⭐️
// MARK: - IvRecordEditIvData
struct IvRecordEditIvData: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: IvRecordEditIvClass?
    
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
        data = (try? values.decode(IvRecordEditIvClass.self, forKey: .data)) ?? nil
    }
}

// ⭐️⭐️
// MARK: - IvRecordEditIvClass
struct IvRecordEditIvClass: Codable {
    let itemInfo: [EditItemInfo]?
    let categoryInfo: [CategoryInfo]
}

// ⭐️⭐️⭐️
// MARK: - EditItemInfo
struct EditItemInfo: Codable {
    let itemIdx: Int
    let name: String
    var categoryIdx, stocksCnt: Int
    let img: String
}
