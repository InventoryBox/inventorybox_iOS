//
//  emailAuthService.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/07/17.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation
import Alamofire


// 이메일 인증하기 서비스 부분
struct emailAuthService {
    static let shared = emailAuthService()
    private func makeParameter(data: String) -> Parameters{
//        print(data)
        return
            [ "sendEmail": data ]
    }
    
    func getRecordEditIvPost(data: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let header: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        let url = APIConstants.emailURL
        
        let dataRequest = Alamofire.request(url, method: .post, parameters: makeParameter(data: data), encoding: JSONEncoding.default, headers: header)
        
        
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
        case 200: return reciveData(by: data)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    private func reciveData(by data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(EmailAuthInformation.self, from: data) else { return .pathErr }
        
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

