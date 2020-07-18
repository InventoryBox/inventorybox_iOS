//
//  SingleGraphData.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/18.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation

struct SingleGraphData: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: SingleGraphWeekInfo?
}

// MARK: - SingleGraphWeekInfo
struct SingleGraphWeekInfo: Codable {
    let alarmCnt, memoCnt, weeksCnt: Int
    let graphInfo: [GraphInfo]
}

// MARK: - GraphInfo
struct GraphInfo: Codable {
    let startDay, endDay: String
    let stocks: [Int]
}

