//
//  NicknameOverlapCheckService.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/09/06.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation
import Alamofire

struct NicknameOverlapCheckService {
    static let shared = NicknameOverlapCheckService()
    private func makeParams(_ nickname: String) -> Parameters {
    return [
        "nickname": nickname
    ]
    }
    
    func nicknameCheck(_ nickname: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        
            let header: HTTPHeaders = ["Content-Type":"application/json"]
            
        let url = APIConstants.nicknameCheckURL

            let dataRequest = Alamofire.request(url, method: .post, parameters: makeParams(nickname), encoding: JSONEncoding.default, headers: header)
            
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
        
        func judge(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
            switch statusCode {
            case 200: return nicknameCheckData(by: data)
            case 400: return .pathErr
            case 500: return .serverErr
            default: return .networkFail
            }
        }
        
         func nicknameCheckData(by data: Data) -> NetworkResult<Any> {
            let decoder = JSONDecoder()
            guard let decodedData = try? decoder.decode(NicknameOverlapCheckData.self, from: data) else { return .pathErr }
            
            // 성공 메시지
            print(decodedData.message)
            
            if decodedData.data!.result == true {
                return .success(decodedData.message)
            } else {
                return .requestErr(decodedData.message)
            }
            
        }
        
    }

