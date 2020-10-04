//
//  IvHomeUserPostInformation.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/09/26.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//


import Foundation

// 필요로 하는 sturct 생성!
struct IvHomeUserPostInformation {
    var postUploadDate : String
    var exepDate : String
    var postImage : String
    var postName : String
    var isSold : Int
    var postPrice : Int
    
    
    init(upload: String, exep: String, image: String, name: String, sold : Int, price:Int) {
        self.postUploadDate = upload
        self.exepDate = exep
        self.postImage = image
        self.postName = name
        self.isSold = sold
        self.postPrice = price
    }
}
