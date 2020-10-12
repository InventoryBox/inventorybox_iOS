//
//  IvExchangeFavoriteInformation.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/10/06.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation

// MARK: - IvHomeUserPostInformation
struct IvExchangeFavoriteInformation: Codable {

        // 서버 통신시
//    let status: Int
//    let success: Bool
//    let message: String
//    let data: ivExchangeFavoriteInfoClass?
//}
//
//// MARK: - DataClass
//struct ivExchangeFavoriteInfoClass: Codable {
//    let ivexchangefavoriteInfo: [ivExchangeFavoriteInfo]
//}
//
//// MARK: - PostInfo
//struct ivExchangeFavoriteInfo: Codable {
//    let postIdx: Int
//    let productImg: String
//    let productName: String
//    let price: Int
//    let expDate: String?
//    let isSold: Int
//    let uploadDate: String
//    let likes: Int
    
    
    var postIdx: Int
    var productImg: String
    var productName: String
    var price: Int
    var expDate: String?
    var isSold: Int
    var uploadDate: String
    var likes: Int
    
    
    init(postIdx: Int, productImg: String, productName: String, price: Int, expDate: String, isSold: Int, uploadDate: String, likes: Int ) {
        
        self.postIdx = postIdx
        self.productImg = productImg
        self.productName = productName
        self.price = price
        self.expDate = expDate
        self.isSold = isSold
        self.uploadDate = uploadDate
        self.likes = likes
 
    }
}
