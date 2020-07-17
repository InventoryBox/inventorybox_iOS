//
//  IvExchangeHomeData.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/17.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation

// MARK: - IvExchangeHomeData
struct IvExchangeHomeData: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: IvExchangeHomeClass?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = (try? values.decode(Int.self, forKey: .status)) ?? -1
        success = (try? values.decode(Bool.self, forKey: .success)) ?? false
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode(IvExchangeHomeClass.self, forKey: .data)) ?? nil
    }
}

// MARK: - IvExchangeHomeClass
struct IvExchangeHomeClass: Codable {
    let postInfo: [PostInfo]
    let addressInfo: String
}

// MARK: - PostInfo
struct PostInfo: Codable {
    let postIdx: Int
    let productImg: String
    let location: String
    let latitude, longitude: Double
    let isFood, price: Int
    let productName: String
    let expDate: String?
    let uploadDate: String
    let distDiff: Int
    var likes: Int
}
