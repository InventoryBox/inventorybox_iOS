//
//  IvHomeHamburgerPrivateInformationPutServcie.swift
//  inventorybox_iOS
//
//  Created by 이재용 on 2020/10/13.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation
import Alamofire

struct IvHomeHamburgerPrivateInformationPutServcie {
    static let shared = IvHomeHamburgerPrivateInformationPutServcie()
    
    private func makeParameter(name: String, storeName: String, phone: String, location: String) -> Parameters {
        return [
            "repName": name,
            "coName": storeName,
            "phoneNumber": phone,
            "location": location
        ]
    }
    
    func putPrivateInformation(name: String, storeName: String, phone: String, location: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        let header: HTTPHeaders = ["Content-Type":"application/json", "token":token]
        
        let dataRequest = Alamofire.request(APIConstants.ivHomePrivateInforamtionURL, method: .put, parameters: makeParameter(name: name, storeName: storeName, phone: phone, location: location), encoding: JSONEncoding.default, headers: header)
        
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
        case 200: return putPrivateInformationData(by: data)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
            
        }
    }
    
    private func putPrivateInformationData(by data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(ProfilePutInformation.self, from: data) else { return .pathErr }
        
        if decodedData.success {
            return .success(decodedData.message)
        } else {
            return .requestErr(decodedData.message)
        }
        
    }
    
}

