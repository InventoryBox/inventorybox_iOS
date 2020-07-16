//
//  IvRecordSuccess.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/17.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation

// MARK: - IvRecordSuccess
struct IvRecordSuccessData: Codable {
    let status: Int
    let success: Bool
    let message: String
}
