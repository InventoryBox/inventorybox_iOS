//
//  IvExchangeDetailData.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/18.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation

// MARK: - IvExchangeDetailData
struct IvExchangeDetailData: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: IvExchangeDetailClass?
}

// MARK: - IvExchangeDetailClass
struct IvExchangeDetailClass: Codable {
    let itemInfo: DetailInfo
    let userInfo: UserInfo
}

// MARK: - ItemInfo
struct DetailInfo: Codable {
    let postIdx: Int
    let productImg: String?
    let productName: String
    let quantity, isFood, price: Int
    let itemInfoDescription, expDate, uploadDate: String?
    let isSold, coverPrice: Int
    let unit: String
    let userIdx, distDiff: Int

    enum CodingKeys: String, CodingKey {
        case postIdx, productImg, productName, quantity, isFood, price
        case itemInfoDescription = "description"
        case expDate, uploadDate, isSold, coverPrice, unit, userIdx, distDiff
    }
}

// MARK: - UserInfo
struct UserInfo: Codable {
    let repName, coName, location, phoneNumber: String
}
