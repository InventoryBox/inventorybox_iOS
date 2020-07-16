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
    let data: AddIvClass?
    
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
        data = (try? values.decode(AddIvClass.self, forKey: .data)) ?? nil
    }
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

