//
//  IvRecordEditCateData.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/17.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation

// ⭐️
// MARK: - IvRecordHomeData
struct IvRecordEditCateData: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: IvRecordEditCateClass?
    
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
        data = (try? values.decode(IvRecordEditCateClass.self, forKey: .data)) ?? nil
    }
}

// ⭐️⭐️
// MARK: - IvRecordEditCateClass
struct IvRecordEditCateClass: Codable {
    let itemInfo: [EditCateInfo]?
    let categoryInfo: [CategoryInfo]
    let isRecorded: Int
    let date: String?
    let picker, addButton: Int
}

// ⭐️⭐️⭐️
// MARK: - HomeItemInfo
// 재고 조회 모델
// 재고 조회, 오늘 재고 기록, 재고 수정 모두 다 다른 데이터로 할까?
struct EditCateInfo: Codable {
    let itemIdx: Int
    let name: String
    let alarmCnt: Int
    let unit: String
    let stocksCnt: Int
    var categoryIdx: Int
    let img: String
    var isSelected: Bool
    
    enum CodingKeys: String, CodingKey {
        case itemIdx
        case name
        case alarmCnt
        case unit
        case stocksCnt
        case categoryIdx
        case img
        case isSelected
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        itemIdx = (try? values.decode(Int.self, forKey: .itemIdx)) ?? -1
        name = (try? values.decode(String.self, forKey: .name)) ?? ""
        alarmCnt = (try? values.decode(Int.self, forKey: .alarmCnt)) ?? -1
        unit = (try? values.decode(String.self, forKey: .unit)) ?? ""
        stocksCnt = (try? values.decode(Int.self, forKey: .stocksCnt)) ?? -1
        categoryIdx = (try? values.decode(Int.self, forKey: .categoryIdx)) ?? -1
        img = (try? values.decode(String.self, forKey: .img)) ?? ""
        isSelected = (try? values.decode(Bool.self, forKey: .isSelected)) ?? false
    }
    
}

