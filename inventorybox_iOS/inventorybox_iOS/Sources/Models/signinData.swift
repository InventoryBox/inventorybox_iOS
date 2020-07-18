//
//  signinData.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/07/18.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation


// MARK: - Welcome
struct signinData: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: signData?
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = (try? values.decode(Int.self, forKey: .status)) ?? -1
        success = (try? values.decode(Bool.self, forKey: .success)) ?? false
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode(signData.self, forKey: .data)) ?? nil
    }
}


// MARK: - DataClass
struct signData: Codable {
    let insertIdx: Int
}
