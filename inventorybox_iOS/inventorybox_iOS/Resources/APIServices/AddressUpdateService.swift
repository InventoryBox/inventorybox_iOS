//
//  AddressUpdateService.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/07/18.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation
import Alamofire


struct AddressUpdateService {
    static let shared = AddressUpdateService()
    
    private func makeParams(_ address: String, _ latitude: String, _ longitude: String) -> Parameters {
        return [
            "address": address,
            "latitude": latitude,
            "longitude": longitude
        ]
    }
    
    func postAddress(_ address: String, _ latitude: String, _ longitude: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        let header: HTTPHeaders = ["Content-Type":"application/json", "token":token]
        
        let url = APIConstants.ivExchangeUpdateAddress

        let dataRequest = Alamofire.request(url, method: .post, parameters: makeParams(address, latitude, longitude), encoding: JSONEncoding.default, headers: header)
        
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
        case 200: return postAddressData(by: data)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    private func postAddressData(by data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
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
