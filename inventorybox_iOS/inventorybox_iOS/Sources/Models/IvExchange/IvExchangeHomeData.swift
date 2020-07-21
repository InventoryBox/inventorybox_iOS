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
}

// MARK: - DataClass
struct IvExchangeHomeClass: Codable {
    let postInfo: [PostInfo]
    let addressInfo: String
}

// MARK: - PostInfo
struct PostInfo: Codable {
    let postIdx: Int
    let productImg: String
    let latitude, longitude: Double
    let isFood, price: Int
    let productName: String
    let expDate: String?
    let uploadDate: String
    var distDiff, likes: Int
}
