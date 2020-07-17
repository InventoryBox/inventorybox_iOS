//
//  emailAuthService.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/07/17.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation
import Alamofire


struct emailAuthService {
    static let shared = emailAuthService()
    
    private func makeParameter(data: HomeItem) -> Parameters{
//        print(data)
       
        return
            ["itemIdx": data.itemIdx,
             "memoCnt": data.memoCnt
                
             
        ]
   
    }
    
    func getRecordEditIvPost(data: HomeItem, completion: @escaping (NetworkResult<Any>) -> Void) {
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZHgiOjEsImVtYWlsIjoicm94YW5lYW1ldGh5QGdtYWlsLmNvbSIsImlhdCI6MTU5NDY0MTQ4M30.oAUMpo6hNxgZ77nYj0bZStOqJLAqJVDMYna93D1NDwo"
        ]
        
        
        let dataRequest = Alamofire.request(APIConstants.ivHomeMemoModifyURL, method: .post, parameters: makeParameter(data: data), encoding: JSONEncoding.default, headers: header)
        
        
//            print(makeParameter(data: data))
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
        case 200: return getHomeMemoPostData(by: data)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    private func getHomeMemoPostData(by data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(HomeInformation.self, from: data) else { return .pathErr }
        
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

