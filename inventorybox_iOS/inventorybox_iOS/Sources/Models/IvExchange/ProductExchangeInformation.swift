//
//  ProductExchangeInformation.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/10.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation

struct ProductExchangeInformation {
    var ivImageName: String
    var ivHeart: Bool
    var ivPrice: String
    var ivDistance: String
    var ivName: String
    var ivLife: String
    var ivDate: String
    
    init(imageName: String, heart: Bool, price: String, distance: String, name: String, life: String, date: String) {
        self.ivImageName = imageName
        self.ivHeart = heart
        self.ivPrice = price
        self.ivDistance = distance
        self.ivName = name
        self.ivLife = life
        self.ivDate = date
    }
}
