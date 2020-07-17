//
//  IvRecordAddIvPostService.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/16.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation
import Alamofire
// ⭐️⭐️
// MARK: - DataClass
//struct AddIvClass: Codable {
//    let iconInfo: [IconInfo]
//    let categoryInfo: [CategoryInfo]
//}

// ⭐️⭐️⭐️
// MARK: - IconInfo
//struct IconInfo: Codable {
//    let iconIdx: Int
//    let img: String
//    let name: String
//}


struct IvRecordAddIvPostService {
    static let shared = IvRecordAddIvPostService()
    
    private func makeParameter(name: String, unit: String, alarmCnt: Int, memoCnt: Int, iconIdx: Int, categoryIdx: Int) -> Parameters{
        
        return
            ["name": name,
             "unit": unit,
             "alarmCnt": alarmCnt,
             "memoCnt": memoCnt,
             "iconIdx": iconIdx,
             "categoryIdx": categoryIdx
            ]
    }
    
    func getRecordAddIvPost(name: String, unit: String, alarmCnt: Int, memoCnt: Int, iconIdx: Int, categoryIdx: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZHgiOjEsImVtYWlsIjoicm94YW5lYW1ldGh5QGdtYWlsLmNvbSIsImlhdCI6MTU5NDY0MTQ4M30.oAUMpo6hNxgZ77nYj0bZStOqJLAqJVDMYna93D1NDwo"
        ]
        
        let dataRequest = Alamofire.request(APIConstants.inventortRecordAddURL, method: .post, parameters: makeParameter(name: name, unit: unit, alarmCnt: alarmCnt, memoCnt: memoCnt, iconIdx: iconIdx, categoryIdx: categoryIdx), encoding: JSONEncoding.default, headers: header)
//        print(makeParameter(name: name, unit: unit, alarmCnt: alarmCnt, memoCnt: memoCnt, iconIdx: iconIdx, categoryIdx: categoryIdx))
        dataRequest.responseData { (dataResponse) in
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else { return }
                guard let value = dataResponse.result.value else { return }
                print(statusCode)
                let networkResult = self.judge(by: statusCode, value)
                
                print("통신은 성공했으나")
                completion(networkResult)
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(.networkFail)
                
            }
            
        }
    }
    
    private func judge(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200: return getRecordAddIvPostData(by: data)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
            
        }
    }
    
    private func getRecordAddIvPostData(by data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        print("hi")
        guard let decodedData = try? decoder.decode(IvRecordSuccessData.self, from: data) else { return .pathErr }
        
        // 성공 메시지
        print(decodedData.message)
        if decodedData.success {
            return .success(decodedData.message)
        } else {
            return .requestErr(decodedData.message)
        }
        
    }
    
}


