//
//  IvRecordAddCateService.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/17.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation
import Alamofire

struct IvRecordAddCateService {
    static let shared = IvRecordAddCateService()
    
    private func makeParameter(name: String) -> Parameters {
        return ["name": name]
    }
    
    func getRecordAddCate(name: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        let header: HTTPHeaders = ["Content-Type":"application/json", "token":token]
        
        let url = APIConstants.inventoryRecordCategoryAddURL

        
        let dataRequest = Alamofire.request(url, method: .post, parameters: makeParameter(name: name), encoding: JSONEncoding.default, headers: header)
        
        dataRequest.responseData { (dataResponse) in
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else { return }
                guard let value = dataResponse.result.value else { return }
                
                let networkResult = self.judge(by: statusCode, value)

                completion(networkResult)
                
            case .failure: completion(.networkFail)
            
            }
            
        }
    }
    
    private func judge(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200: return getRecordAddCateData(by: data)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    private func getRecordAddCateData(by data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(IvRecordSuccessData.self, from: data) else { return .pathErr }
    
        
        if decodedData.success {
            return .success(decodedData.message)
        } else {
            return .requestErr(decodedData.message)
        }
        
    }
    
}





