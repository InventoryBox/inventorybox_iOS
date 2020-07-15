//
//  orderCheckMemoTVCImfo.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/07/13.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation

struct orderCheckMemoTVCInfo {
    
    var productImage : String
    var productName: String
    var productCount: Int

    
    init(productimage: String, productname: String, productcount: Int) {
        self.productImage = productimage
        self.productName = productname
        self.productCount = productcount
        }
    
}
