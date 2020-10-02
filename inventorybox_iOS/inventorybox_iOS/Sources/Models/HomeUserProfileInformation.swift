//
//  HomeUserProfileInformation.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/09/09.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//


import Foundation

// MARK: - HomeUserProfileInformation
struct HomeUserProfileInformation: Codable {
    let status: Int
    let success: Bool
    let data: profile
}

// MARK: - profile
struct profile: Codable {
    let nickname: String
    let img: String
    let coName: String
}
