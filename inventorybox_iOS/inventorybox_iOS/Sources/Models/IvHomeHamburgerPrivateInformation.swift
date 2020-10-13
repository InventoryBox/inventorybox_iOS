//
//  IvHomeHamburgerPrivateInformation.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/10/13.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation

// MARK: - IvHomeHamburgerPrivateInformation
struct IvHomeHamburgerPrivateInformation: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: PrivateInformationData?
    
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
           data = (try? values.decode(PrivateInformationData.self, forKey: .data)) ?? nil
       }
}

// MARK: - PrivateInformationData
struct PrivateInformationData: Codable {
    let result: [PrivateInformation]
}

// MARK: - Result
struct PrivateInformation: Codable {
    let repName, coName, phoneNumber: String
    let location: String?
}
