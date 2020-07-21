//
//  IvExchangeDetailService.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/18.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation
import Alamofire

struct IvExchangeDetailService {
    static let shared = IvExchangeDetailService()
    
    func getExchangeDetail(idx: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        let header: HTTPHeaders = ["Content-Type":"application/json", "token":token]
        
        let url = APIConstants.ivExchangePostDetailURL + "\(idx)"
        let dataRequest = Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: header)
        
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
        case 200: return getExchangeDetailData(by: data)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    private func getExchangeDetailData(by data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        print("here?")
        guard let decodedData = try? decoder.decode(IvExchangeDetailData.self, from: data) else { return .pathErr }
        
        guard let data = decodedData.data else { return .pathErr }
        // 성공 메시지
        print(decodedData.message)
        
        if decodedData.success {
            return .success(data)
        } else {
            return .requestErr(decodedData.message)
        }
        
    }
    
}


