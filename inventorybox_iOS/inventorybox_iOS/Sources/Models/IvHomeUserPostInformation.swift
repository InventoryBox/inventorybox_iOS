//
//  HomeSideMyInfoVC.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/10/06.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation

struct IvHomeUserPostInformation: Codable {
    
    // 통신 했을 때 Information임
    
    //    let status: Int
    //    let success: Bool
    //    let message: String
    //    let data: UserPostItemClass?
    //}
    //
    //// MARK: - DataClass
    //struct UserPostItemClass: Codable {
    //    let userPostItem: [UserPostItem]
    //}
    //
    //// MARK: - Result
    //struct UserPostItem: Codable {
    //    let postIdx: Int
    //    let productImg: String
    //    let productName: String
    //    let expDate: String
    //    let coverPrice, isSold: Int
    //    let uploadDate: String
    
    
    var uploadDate : String
    var expDate : String
    var productImg : String
    var productName : String
    var isSold : Int
    var coverPrice : Int
    
    
    init(upload: String, exep: String, image: String, name: String, sold : Int, price:Int) {
        self.uploadDate = upload
        self.expDate = exep
        self.productImg = image
        self.productName = name
        self.isSold = sold
        self.coverPrice = price
    }
}

