//
//  LoginService.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/14.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation
import Alamofire

struct LoginService {
    static let shared = LoginService()
    
    func login(id: String, pw: String, completion: @escaping (NetworkResult<Any>) -> Void){
        
        let header: HTTPHeaders = ["Content-Type": "application/json"]
        
        let body: Parameters = [
            "email" : id,
            "password": pw
        ]
        
        Alamofire.request(APIConstants.loginURL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else {
                    return
                }
                guard let value = response.result.value else {
                    return
                }
                completion(self.isCorrectUser(statusCode: statusCode, data: value))
            case .failure(let err):
                print(err.localizedDescription)
                completion(.networkFail)
            }
        }
    }
    
    private func isCorrectUser(statusCode: Int, data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(LoginData.self, from: data) else {
            return .pathErr
        }
        guard let tokenData = decodedData.data else {
            return .requestErr(decodedData.message)
        }
        
        switch statusCode {
        case 200:
            return .success(tokenData.token)
        case 400:
            return .pathErr
        case 500:
            return .requestErr(decodedData.message)
        default:
            return .pathErr
        }
    }
}


