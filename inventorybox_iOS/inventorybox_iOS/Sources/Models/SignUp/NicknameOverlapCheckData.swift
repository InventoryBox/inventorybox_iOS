//
//  NicknameOverlapCheckData.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/09/06.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation

struct NicknameOverlapCheckData: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: NicknameData?
}

// MARK: - NicknameData
struct NicknameData: Codable {
    let result: Bool
}

