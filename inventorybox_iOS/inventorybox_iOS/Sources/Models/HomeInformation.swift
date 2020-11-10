//
//  HomeInformation.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/07/17.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation

// MARK: - HomeInformation Struct 만들기
struct HomeInformation: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: HomeItemclass?
    
    //값이 없을 경우 nil값 집어넣기?
//      init(from decoder: Decoder) throws {
//          let values = try decoder.container(keyedBy: CodingKeys.self)
//          status = (try? values.decode(Int.self, forKey: .status)) ?? -1
//          success = (try? values.decode(Bool.self, forKey: .success)) ?? false
//          message = (try? values.decode(String.self, forKey: .message)) ?? ""
//          data = (try? values.decode(HomeItemclass.self, forKey: .data)) ?? nil
//      }
}

// MARK: - DataClass
struct HomeItemclass: Codable {
    let result: [HomeItem]
}

// MARK: - Result
struct HomeItem: Codable {
    let categoryIdx : Int
    let itemIdx : Int
    var categoryName : String
    var flag: Int
    let itemName, unit: String
    var alarmCnt: Int
    var memoCnt, presentCnt: Int
    let img: String
    let iconName: String
    let stocksInfo: [Int]
}

//"categoryIdx": 64,
//            "itemIdx": 117,
//            "categoryName": "채소",
//            "flag": 1,
//            "itemName": "당근",
//            "unit": "캐럿",
//            "alarmCnt": 5,
//            "memoCnt": 7,
//            "presentCnt": 1,
//            "img": "https://inventorybox.s3.ap-northeast-2.amazonaws.com/icon/ic_carrot.png",
//            "iconName": "carrot",
//            "lastDay": 2,
//            "stocksInfo": [
//                1,
//                12,
//                -1,
//                -1,
//                -1
//            ]
