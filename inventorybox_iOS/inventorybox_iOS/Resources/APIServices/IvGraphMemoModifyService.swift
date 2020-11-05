//
//  IvGraphMemoModifyService.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/10/12.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation
import Alamofire


struct IvGraphMemoModifyService {
    static let shared = IvGraphMemoModifyService()
    
    private func makeParameter(itemIdx: Int) -> Parameters{
        
        return [ "itemIdx" : itemIdx]
    }

    
    func postGraphModify(itemIdx: Int,alarmCnt: Int,memoCnt:Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        
       
        
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        let header: HTTPHeaders = ["Content-Type":"application/json", "token":token]
        
        
        let body: Parameters = [
            "alarmCnt" : alarmCnt,
            "memoCnt" : memoCnt
            
        ]
        
        let url = APIConstants.baseURL + "dashboard/" + String(itemIdx) + "/modifyCnt"
        
        print(url)
        
        let dataRequest = Alamofire.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header)
        
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
        case 200: return postModifyData(by: data)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
            
        }
    }
    
    private func postModifyData(by data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(IvRecordSuccessData.self, from: data) else { return .pathErr }
        
        
        if decodedData.success {
            return .success(decodedData.message)
        } else {
            return .requestErr(decodedData.message)
        }
        
    }
    
}


