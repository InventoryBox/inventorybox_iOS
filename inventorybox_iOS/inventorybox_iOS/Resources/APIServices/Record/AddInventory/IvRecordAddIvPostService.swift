//
//  IvRecordAddIvPostService.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/16.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation
import Alamofire

struct IvRecordAddIvPostService {
    static let shared = IvRecordAddIvPostService()
    
    private func makeParameter(name: String, unit: String, alarmCnt: Int, memoCnt: Int, iconIdx: Int, categoryIdx: Int) -> Parameters{
        
        return
            ["name": name,
             "unit": unit,
             "alarmCnt": alarmCnt,
             "memoCnt": memoCnt,
             "iconIdx": iconIdx,
             "categoryIdx": categoryIdx]
    }
    
    func getRecordAddIvPost(name: String, unit: String, alarmCnt: Int, memoCnt: Int, iconIdx: Int, categoryIdx: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        let header: HTTPHeaders = ["Content-Type":"application/json", "token":token]
        
        let dataRequest = Alamofire.request(APIConstants.inventortRecordAddURL, method: .post, parameters: makeParameter(name: name, unit: unit, alarmCnt: alarmCnt, memoCnt: memoCnt, iconIdx: iconIdx, categoryIdx: categoryIdx), encoding: JSONEncoding.default, headers: header)
        dataRequest.responseData { (dataResponse) in
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else { return }
                guard let value = dataResponse.result.value else { return }
                print(statusCode)
                let networkResult = self.judge(by: statusCode, value)
                
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
        guard let decodedData = try? decoder.decode(IvRecordSuccessData.self, from: data) else { return .pathErr }
        
        if decodedData.success {
            return .success(decodedData.message)
        } else {
            return .requestErr(decodedData.message)
        }
        
    }
    
}


