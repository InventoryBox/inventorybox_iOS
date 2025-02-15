//
//  HomeService.swift
//  inventorybox_iOS
//
//  Created by 송황호 on 2020/07/17.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import Foundation
import Alamofire

struct HomeService {
    static let shared = HomeService()
    
    func getHome(completion: @escaping (NetworkResult<Any>) -> Void) {
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        let header: HTTPHeaders = ["Content-Type":"application/json", "token":token]
        
        let url = APIConstants.ivHomeURL
//        print(url)
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
        case 200: return getHomeData(by: data)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    private func getHomeData(by data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
//        print("hi")
        guard let decodedData = try? decoder.decode(HomeInformation.self, from: data) else { return .pathErr }
//        print(decodedData)
        guard let data = decodedData.data else { return .pathErr }
        // 성공 메시지
//        print(decodedData.message)
        
        if decodedData.success {
            return .success(data)
        } else {
            return .requestErr(decodedData.message)
        }
        
    }
    
}
