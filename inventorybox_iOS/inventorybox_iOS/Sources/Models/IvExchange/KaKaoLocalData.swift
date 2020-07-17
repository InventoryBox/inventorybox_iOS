//
//  KaKaoLocalData.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/13.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let kaKaoLocalService = try? newJSONDecoder().decode(KaKaoLocalService.self, from: jsonData)

import Foundation

// MARK: - KaKaoLocalService
struct KaKaoLocalData: Codable {
    let documents: [Document]
    let meta: Meta
}

// MARK: - Document
struct Document: Codable {
    let address: Address?
    let addressName, addressType: String
    let roadAddress: RoadAddress?
    let x, y: String

    enum CodingKeys: String, CodingKey {
        case address
        case addressName = "address_name"
        case addressType = "address_type"
        case roadAddress = "road_address"
        case x, y
    }
}

// MARK: - Address
struct Address: Codable {
    let addressName, bCode, hCode, mainAddressNo: String
    let mountainYn, region1DepthName, region2DepthName, region3DepthHName: String
    let region3DepthName, subAddressNo, x, y: String

    enum CodingKeys: String, CodingKey {
        case addressName = "address_name"
        case bCode = "b_code"
        case hCode = "h_code"
        case mainAddressNo = "main_address_no"
        case mountainYn = "mountain_yn"
        case region1DepthName = "region_1depth_name"
        case region2DepthName = "region_2depth_name"
        case region3DepthHName = "region_3depth_h_name"
        case region3DepthName = "region_3depth_name"
        case subAddressNo = "sub_address_no"
        case x, y
    }
}

// MARK: - Meta
struct Meta: Codable {
    let isEnd: Bool
    let pageableCount, totalCount: Int

    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}
// MARK: - RoadAddress
struct RoadAddress: Codable {
    let addressName, buildingName, mainBuildingNo: String
    let region1DepthName, region2DepthName, region3DepthName: String
    let roadName, subBuildingNo: String
    let undergroundYn: String
    let x, y, zoneNo: String

    enum CodingKeys: String, CodingKey {
        case addressName = "address_name"
        case buildingName = "building_name"
        case mainBuildingNo = "main_building_no"
        case region1DepthName = "region_1depth_name"
        case region2DepthName = "region_2depth_name"
        case region3DepthName = "region_3depth_name"
        case roadName = "road_name"
        case subBuildingNo = "sub_building_no"
        case undergroundYn = "underground_yn"
        case x, y
        case zoneNo = "zone_no"
    }
}
