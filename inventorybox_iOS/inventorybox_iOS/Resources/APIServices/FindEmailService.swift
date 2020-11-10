//
//  FindEmailService.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/11/01.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//


import Foundation
import Alamofire


// 이메일 찾기
struct FindEmailService {
    static let shared = FindEmailService()
    private func makeParameter(repName: String, coName: String, phone: String) -> Parameters{
//        print(data)
        return
            [ "repName": repName, "coName":coName, "phoneNumber": phone]
    }
    
    func findEmailPost(repName: String, coName: String, phone: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        let header: HTTPHeaders = ["Content-Type":"application/json", "token":token]
        
        let url = APIConstants.findEmailURL
        
        let dataRequest = Alamofire.request(url, method: .post, parameters: makeParameter(repName: repName, coName: coName, phone: phone), encoding: JSONEncoding.default, headers: header)
        
        // 무슨 값이 보내졌는지 확인
//      print(makeParameter(repName: repName, coName: coName, phone: phone))
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
        guard let decodedData = try? decoder.decode(FindEmailInformation.self, from: data) else { return .pathErr }
        
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

