//
//  HomeMemoModifyService.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/07/17.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation
import Alamofire

// MARK: post service생성 했습니다.
struct HomeMemoModifyPostService {
    static let shared = HomeMemoModifyPostService()
    
    private func makeParameter(data: [HomeItem]) -> Parameters{
        
        var parsingParameter: [[String: Int]] = []
        
        for d in data {
            let item = [
                "itemIdx": d.itemIdx,
                "memoCnt": d.memoCnt
            ]
            parsingParameter.append(item)
            print(parsingParameter)

        }
        
        
        return ["itemInfo": parsingParameter]
    }
    
    
    func getHomeMemoAuthPost(data: [HomeItem], completion: @escaping (NetworkResult<Any>) -> Void) {
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        let header: HTTPHeaders = ["Content-Type":"application/json", "token":token]
        
        
        let dataRequest = Alamofire.request(APIConstants.ivHomeMemoModifyURL, method: .put, parameters: makeParameter(data: data), encoding: JSONEncoding.default, headers: header)
        
        dataRequest.responseData { (dataResponse) in
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else { return }
                guard let value = dataResponse.result.value else { return }
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
        guard let decodedData = try? decoder.decode(BasicModel.self, from: data) else { return .pathErr }
        
        // 성공 메시지
//        print(decodedData.message)
        
        if decodedData.success {
            return .success(decodedData.message)
        } else {
            return .requestErr(decodedData.message)
        }
        
    }
    
}

