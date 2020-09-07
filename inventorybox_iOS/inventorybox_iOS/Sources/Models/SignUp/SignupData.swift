//
//  SignupData.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/09/06.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation

struct SignupData:Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: SignUpDataClass
}

// MARK: - SignUpDataClass
struct SignUpDataClass: Codable {
    let insertIdx: Int
}
