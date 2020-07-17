//
//  IvRecordTodayPostService.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/16.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation
import Alamofire

//struct TodayItemInfo: Codable {
//    let itemIdx: Int
//    let name: String
//    let categoryIdx: Int
//    var presentCnt: Int?
//}

struct IvRecordTodayPostService {
    static let shared = IvRecordTodayPostService()
    
    private func makeParameter(data: [TodayItemInfo], date: String) -> Parameters{
        
        var parsingParameter: [[String: Int]] = []
        
        
        for d in data {
            
            let item = [
                "itemIdx" : d.itemIdx,
                "presentCnt": d.presentCnt!
            ]
            
            parsingParameter.append(item)
            
        }
        
        return ["itemInfo": parsingParameter,
        "date": date]
    }
    
    func getRecordTodayIvPost(data: [TodayItemInfo], date: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZHgiOjEsImVtYWlsIjoicm94YW5lYW1ldGh5QGdtYWlsLmNvbSIsImlhdCI6MTU5NDY0MTQ4M30.oAUMpo6hNxgZ77nYj0bZStOqJLAqJVDMYna93D1NDwo"
        ]
        
        let dataRequest = Alamofire.request(APIConstants.inventoryRecordModifyURL, method: .put, parameters: makeParameter(data: data, date: date), encoding: JSONEncoding.default, headers: header)
        
        //        print(makeParameter(data: data, date: date))
        dataRequest.responseData { (dataResponse) in
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else { return }
                guard let value = dataResponse.result.value else { return }
                print(statusCode)
                let networkResult = self.judge(by: statusCode, value)
                
                print("dafsda")
                completion(networkResult)
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(.networkFail)
                
            }
            
        }
    }
    
    private func judge(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200: return getRecordTodayIvPostData(by: data)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
            
        }
    }
    
    private func getRecordTodayIvPostData(by data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(IvRecordEditIvData.self, from: data) else { return .pathErr }
        
        // 성공 메시지
        print(decodedData.message)
        
        guard let data = decodedData.data else { return .pathErr }
        
        if decodedData.success {
            return .success(data)
        } else {
            return .requestErr(decodedData.message)
        }
        
    }
    
}


