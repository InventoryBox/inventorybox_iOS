//
//  ProfilePutInformation.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/10/13.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation

// MARK: - ProfilePutInformation
struct ProfilePutInformation: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: ProfilePutData?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case success = "success"
        case message = "message"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
           let values = try decoder.container(keyedBy: CodingKeys.self)
           status = (try? values.decode(Int.self, forKey: .status)) ?? -1
           success = (try? values.decode(Bool.self, forKey: .success)) ?? false
           message = (try? values.decode(String.self, forKey: .message)) ?? ""
           data = (try? values.decode(ProfilePutData.self, forKey: .data)) ?? nil
       }
}

// MARK: - ProfilePutData
struct ProfilePutData: Codable {
    let result: Bool
}
