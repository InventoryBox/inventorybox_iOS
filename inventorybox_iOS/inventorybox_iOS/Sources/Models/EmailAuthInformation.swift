//
//  EmailAuthInformation.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/07/17.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//


import Foundation

// MARK: - EmailAuthInformation
struct EmailAuthInformation: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: reciveData?
    
    init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
        status = (try? values.decode(Int.self, forKey: .status)) ?? -1
        success = (try? values.decode(Bool.self, forKey: .success)) ?? false
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode(reciveData.self, forKey: .data)) ?? nil
    }
}

// MARK: - DataClass
struct reciveData: Codable {
    let number: Int
}
