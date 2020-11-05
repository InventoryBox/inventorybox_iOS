//
//  IvHomeHamburgerProfileInformation.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/10/14.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation

// MARK: - IvHomeHamburgerProfileInformation
struct IvHomeHamburgerProfileInformation: Codable {
    let status: Int
    let success: Bool
    let data: ProfileData?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case success = "success"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
           let values = try decoder.container(keyedBy: CodingKeys.self)
           status = (try? values.decode(Int.self, forKey: .status)) ?? -1
           success = (try? values.decode(Bool.self, forKey: .success)) ?? false
           data = (try? values.decode(ProfileData.self, forKey: .data)) ?? nil
       }
}

// MARK: - ProfileData
struct ProfileData: Codable {
    let nickname: String
    let img: String
    let coName: String
}
