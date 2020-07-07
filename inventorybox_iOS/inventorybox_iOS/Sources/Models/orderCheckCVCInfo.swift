//
//  orderCheckCVC.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/07/07.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation

// 필요로 하는 sturct 생성!
struct orderCheckCVCInfo {
    
    var checkImage : String
    var productName: String
    
    init(productimage: String, productname: String){
        self.checkImage = productimage
        self.productName = productname
    }
}
