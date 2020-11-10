//
//  FindEmailInformation.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/11/01.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation

// MARK: - FindEmailInformation
struct FindEmailInformation : Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: reciveEmailData?
    
    
    init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
        status = (try? values.decode(Int.self, forKey: .status)) ?? -1
        success = (try? values.decode(Bool.self, forKey: .success)) ?? false
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode(reciveEmailData.self, forKey: .data)) ?? nil
    }
}

// MARK: - reciveEmailData
struct reciveEmailData: Codable {
    let email: [Email]
}

// MARK: - Email
struct Email: Codable {
    let email: String
}
