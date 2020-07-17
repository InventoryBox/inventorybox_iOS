//
//  TagModel.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/14.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation

struct TagModel{
    var tagName:String = ""
    var idx:Int = 0
    
    init(tagName:String, idx:Int) {
        self.tagName = tagName
        self.idx = idx
    }
}
