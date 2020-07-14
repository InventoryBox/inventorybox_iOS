//
//  orderCheckImformation.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/07/06.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation


// 필요로 하는 sturct 생성!
struct orderCheckTVCInfo {
    
    var productImage : String
    var productName: String
    var productCount: Int
    var productSet: String
    
    init(productimage: String, productname: String, productcount: Int, productset: String) {
        self.productImage = productimage
        self.productName = productname
        self.productCount = productcount
        self.productSet = productset
    }
}
